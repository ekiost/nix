{ ... }:
{
  programs = {
    fish = {
      enable = true;
      interactiveShellInit = ''
        set -g fish_greeting # Disable greeting

        # Completions for the `axet` wrapper
        set -l axet_cmds agent backup completion dirs help login logout logs models projects run stats team
        complete -c axet -f

        # Subcommands (only when none has been typed yet)
        complete -c axet -n "not __fish_seen_subcommand_from $axet_cmds" -a agent      -d "Manage agent definitions"
        complete -c axet -n "not __fish_seen_subcommand_from $axet_cmds" -a backup     -d "Manage backups of the project's .axet-code directory"
        complete -c axet -n "not __fish_seen_subcommand_from $axet_cmds" -a completion -d "Generate the autocompletion script"
        complete -c axet -n "not __fish_seen_subcommand_from $axet_cmds" -a dirs       -d "Print directories used by AXET"
        complete -c axet -n "not __fish_seen_subcommand_from $axet_cmds" -a help       -d "Help about any command"
        complete -c axet -n "not __fish_seen_subcommand_from $axet_cmds" -a login      -d "Login to AXET via Okta SSO"
        complete -c axet -n "not __fish_seen_subcommand_from $axet_cmds" -a logout     -d "Logout from AXET"
        complete -c axet -n "not __fish_seen_subcommand_from $axet_cmds" -a logs       -d "View axet-code logs"
        complete -c axet -n "not __fish_seen_subcommand_from $axet_cmds" -a models     -d "List all available models"
        complete -c axet -n "not __fish_seen_subcommand_from $axet_cmds" -a projects   -d "List project directories"
        complete -c axet -n "not __fish_seen_subcommand_from $axet_cmds" -a run        -d "Run a single non-interactive prompt"
        complete -c axet -n "not __fish_seen_subcommand_from $axet_cmds" -a stats      -d "Show usage statistics"
        complete -c axet -n "not __fish_seen_subcommand_from $axet_cmds" -a team       -d "Manage the project's agent ecosystem manifest"

        # Flags
        complete -c axet -l agent         -x -d "Primary agent to chat with for this run"
        complete -c axet -s c -l cwd      -r -a "(__fish_complete_directories)" -d "Current working directory"
        complete -c axet -s D -l data-dir -r -a "(__fish_complete_directories)" -d "Custom axet-code data directory"
        complete -c axet -s d -l debug       -d "Debug"
        complete -c axet -s h -l help        -d "Help"
        complete -c axet -l trust-project    -d "Trust and load the agent ecosystem in this project"
        complete -c axet -s v -l version     -d "Version for axet-code"
        complete -c axet -s y -l yolo        -d "Automatically accept all permissions (dangerous)"
      '';
      shellAliases = {
        config-update = "nix flake update --flake ~/.config/nix";
      };
      functions = {
        axet = {
          description = "Run axet-code via Windows PowerShell, defaulting cwd to the current WSL dir";
          body = ''
            set -l has_cwd 0
            set -l has_data 0
            for a in $argv
              switch $a
                case -c --cwd '--cwd=*'
                  set has_cwd 1
                case -D --data-dir '--data-dir=*'
                  set has_data 1
              end
            end

            # Defaults, only added when the user didn't pass them
            set -l extra
            if test $has_cwd -eq 0
              set -a extra -c (wslpath -w $PWD)
            end
            # Keep the SQLite data dir on C: when the project is on the WSL share,
            # since SQLite locking fails over \\wsl.localhost
            if test $has_data -eq 0; and not string match -q '/mnt/*' -- $PWD
              set -a extra -D 'C:/Users/choonkeat.ling/.axet-code'
            end

            # Single-quote each arg for PowerShell so spaces/quotes survive
            set -l quoted
            for a in $extra $argv
              set -a quoted "'"(string replace -a "'" "'''" -- $a)"'"
            end

            powershell.exe -NoProfile -Command "Set-Location C:/Users/choonkeat.ling; axet-code.exe $quoted"
          '';
        };
      };
    };

    starship = {
      enable = true;
      enableFishIntegration = true;
      enableTransience = true;
    };

    git = {
      enable = true;
      lfs.enable = true;
      ignores = [
        ".DS_Store"
        ".vscode"
        ".idea"
        ".env*"
      ];
      settings = {
        user.name = "ekiost";
        user.email = "choonkeatling@icloud.com";
        init.defaultBranch = "main";
        push.autoSetupRemote = true;
        core.autocrlf = "input";
      };
    };

    git-credential-oauth.enable = true;
  };
}
