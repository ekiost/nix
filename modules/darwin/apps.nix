{ ... }:
{
  homebrew = {
    enable = true;
    casks = [
      "discord"
      "microsoft-excel"
      "microsoft-powerpoint"
      "microsoft-word"
      "steam"
      "telegram"
      "unnaturalscrollwheels"
      "visual-studio-code"
      "zoom"
      "google-chrome"
      "vnc-viewer"
    ];
    onActivation.cleanup = "zap";
  };
}
