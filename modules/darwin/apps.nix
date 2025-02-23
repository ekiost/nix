{ ... }:
{
  homebrew = {
    enable = true;
    casks = [
      "discord"
      "mos"
      "steam"
      "telegram"
      "visual-studio-code"
      "zoom"
    ];
    onActivation.cleanup = "zap";
  };
}
