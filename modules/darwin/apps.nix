{ ... }:
{
  homebrew = {
    enable = true;
    casks = [
      "discord"
      "fleet"
      "mos"
      "telegram"
    ];
    onActivation.cleanup = "zap";
  };
}
