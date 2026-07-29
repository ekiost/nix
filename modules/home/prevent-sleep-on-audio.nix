{ pkgs, nowplaying-cli-src, ... }:
let
  nowplaying-cli = pkgs.callPackage ./nowplaying-cli.nix { src = nowplaying-cli-src; };

  preventSleepScript = pkgs.writeShellApplication {
    name = "prevent-sleep-on-audio";
    text = ''
      caffeinate_pid=""

      log() {
        printf '%s %s\n' "$(date '+%Y-%m-%d %H:%M:%S')" "$1"
      }

      cleanup() {
        if [ -n "$caffeinate_pid" ]; then
          kill "$caffeinate_pid" 2>/dev/null || true
        fi
        exit 0
      }
      trap cleanup TERM INT EXIT

      is_audio_playing() {
        [ "$(${nowplaying-cli}/bin/nowplaying-cli get playbackRate 2>/dev/null)" = "1" ]
      }

      while true; do
        if is_audio_playing; then
          if [ -z "$caffeinate_pid" ] || ! kill -0 "$caffeinate_pid" 2>/dev/null; then
            /usr/bin/caffeinate -s -d &
            caffeinate_pid=$!
            log "audio detected -> caffeinate started (pid $caffeinate_pid)"
          fi
        else
          if [ -n "$caffeinate_pid" ] && kill -0 "$caffeinate_pid" 2>/dev/null; then
            kill "$caffeinate_pid"
            log "audio stopped -> caffeinate (pid $caffeinate_pid) killed"
          fi
          caffeinate_pid=""
        fi
        sleep 20
      done
    '';
  };
in
{
  launchd.agents.prevent-sleep-on-audio = {
    enable = true;
    config = {
      ProgramArguments = [ "${preventSleepScript}/bin/prevent-sleep-on-audio" ];
      RunAtLoad = true;
      KeepAlive = true;
      ProcessType = "Background";
      StandardOutPath = "/tmp/prevent-sleep-on-audio.log";
      StandardErrorPath = "/tmp/prevent-sleep-on-audio.err.log";
    };
  };
}
