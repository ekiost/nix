{ ... }:
{
  homebrew = {
    enable = true;
    casks = [
      "discord"
      "telegram"
      "zed"
    ];
    onActivation.cleanup = "zap";
  };
}
