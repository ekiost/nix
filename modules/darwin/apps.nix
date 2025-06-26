{ ... }:
{
  homebrew = {
    enable = true;
    casks = [
      "discord"
      "mos"
      "telegram"
      "microsoft-word"
      "zoom"
      "zed"
    ];
    onActivation.cleanup = "zap";
  };
}
