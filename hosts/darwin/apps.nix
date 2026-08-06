{ ... }:
{
  homebrew = {
    enable = true;
    casks = [
      "visual-studio-code"
    ];
    onActivation.cleanup = "zap";
  };
}
