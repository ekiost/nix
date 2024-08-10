{ pkgs, user, ... }: {
  services.nix-daemon.enable = true;

  nix.settings.experimental-features = "nix-command flakes";

  # Used for backwards compatibility. please read the changelog before changing: `darwin-rebuild changelog`.
  system.stateVersion = 4;

  # The Nixpkgs repository to use with nix-darwin and unable unfree packages.
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
  users.users.${user}.home = "/users/${user}";

  # Enable Touch ID for `sudo`.
  security.pam.enableSudoTouchIdAuth = true;

  programs.zsh.enable = true;

  environment = {
    shells = with pkgs; [ bash zsh ];
    loginShell = pkgs.zsh;
    systemPackages = [ pkgs.coreutils ];
  };

  system.defaults.CustomUserPreferences = {
    "com.apple.finder" = {
      "NSWindowTabbingShoudShowTabBarKey-com.apple.finder.TBrowserWindow" = true;
    };

    # Safari settings.
    "com.apple.Safari" = {
      AlwaysShowTabBar = true;
      ShowStatusBar = true;
      IncludeDevelopMenu = true;
    };

    "com.apple.Safari.SandboxBroker" = {
      ShowDevelopMenu = true;
    };

    "com.apple.dock" = {
      expose-group-apps = true;
    };

    # Control Center settings.
    "com.apple.controlcenter" = {
      BatteryShowPercentage = true;
    };

    # Terminal settings.
    "com.apple.Terminal" = {
      NSWindowTabbingShoudShowTabBarKey-TTWindow-TTWindowController-TTWindowController-VT-FS = true;
    };

    # Function key usage
    "com.apple.HIToolbox" = {
      AppleFnUsageType = 2;
    };

    # Show Music song notifications
    "com.apple.Music" = {
      userWantsPlaybackNotifications = false;
    };
  };

  system.defaults = {
    finder = {
      FXPreferredViewStyle = "clmv";
      ShowPathbar = true;
      ShowStatusBar = true;
    };
    dock = {
      magnification = true;
      tilesize = 30;
      largesize = 60;
      minimize-to-application = true;
      wvous-bl-corner = 1;
      wvous-br-corner = 1;
      wvous-tl-corner = 1;
      wvous-tr-corner = 1;
      persistent-apps = [
        "/System/Applications/Launchpad.app"
        "/System/Applications/Messages.app"
        "/System/Applications/FaceTime.app"
        "/Applications/Safari.app"
        "/Applications/Telegram.app"
        "/Applications/Discord.app"
        "/System/Applications/Mail.app"
        "/System/Applications/Maps.app"
        "/System/Applications/Calendar.app"
        "/System/Applications/Photos.app"
        "/System/Applications/Reminders.app"
        "/System/Applications/Notes.app"
        "/Applications/Visual Studio Code.app"
        "/System/Applications/Utilities/Terminal.app"
        "/System/Applications/Music.app"
        "/System/Applications/System Settings.app"
      ];
    };
  };

  homebrew = {
    enable = true;
    onActivation.cleanup = "zap";
    casks = [
      "discord"
      "microsoft-word"
      "microsoft-powerpoint"
      "microsoft-excel"
      "mos"
      "telegram"
      "visual-studio-code"
      "zoom"
    ];
  };
}
