{ ... }:
{
  homebrew = {
    enable = true;
    casks = [
      "zed"
    ];
    onActivation.cleanup = "zap";
  };
}
