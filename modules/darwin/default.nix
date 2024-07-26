{ pkgs, self, user, ... }:
{
  # The system-wide Nix configuration.
  services.nix-daemon.enable = true;

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  # The NixOS configuration revision to use with nix-darwin.
  system.configurationRevision = self.rev or self.dirtyRev or null;

  # Used for backwards compatibility. please read the changelog before changing: `darwin-rebuild changelog`.
  system.stateVersion = 4;

  # The Nixpkgs repository to use with nix-darwin.
  nixpkgs = {
    hostPlatform = "aarch64-darwin";
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };

  # The fonts to install.
  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "Meslo" ]; })
  ];

  # Declare the user that will be running `nix-darwin`.
  users.users.${user} = {
    name = user;
    home = "/Users/${user}";
  };

  # The Darwin configuration.
  system.defaults.CustomUserPreferences = {
    # Safari settings.
    "com.apple.Safari" = {
      AlwaysShowTabBar = true;
      ShowStatusBar = true;
      IncludeDevelopMenu = true;
      DeveloperMenuVisibility = true;
      WebKitDeveloperExtrasEnabledPreferenceKey = true;
      "WebKitPreferences.developerExtrasEnabled" = true;
    };

    # Finder settings.
    "com.apple.finder" = {
      FXPreferredViewStyle = "clmv";
      _FXSortFoldersFirst = true;
      ShowPathbar = true;
      ShowStatusBar = true;
    };

    # Control Center settings.
    "com.apple.controlcenter" = {
      BatteryShowPercentage = true;
    };

    # Terminal settings.
    "com.apple.Terminal" = {
      NSWindowTabbingShoudShowTabBarKey-TTWindow-TTWindowController-TTWindowController-VT-FS = true;
    };
  };

  # The Dock settings.
  system.defaults.dock = {
    magnification = true;
    tilesize = 30;
    largesize = 60;
  };

  # Enable Touch ID for `sudo`.
  security.pam.enableSudoTouchIdAuth = true;

  # The Homebrew configuration.
  homebrew = {
    enable = true;
    onActivation.cleanup = "zap";
    casks = [ "docker" "discord" "microsoft-word" "microsoft-powerpoint" "microsoft-excel" "mos" "telegram" ];
  };
}
