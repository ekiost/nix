{ ... }:
{
  homebrew = {
    enable = true;
    casks = [
      "discord"
      "mos"
      "steam"
      "telegram"
      "zed"
    ];
    onActivation.cleanup = "zap";
  };
}
