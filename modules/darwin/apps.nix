{ ... }:
{
  homebrew = {
    enable = true;
    casks = [
      "discord"
      "mos"
      "telegram"
      "zed"
    ];
    onActivation.cleanup = "zap";
  };
}
