{ pkgs, user, ... }: {
  # Enable the Nix daemon service
  services.nix-daemon.enable = true;

  # Enable the Nix flakes feature
  nix.settings.experimental-features = "nix-command flakes";

  # Enable automatic optimization of the Nix store
  nix.settings.auto-optimise-store = true;

  # Set the system state version (for backwards compatibility)
  system.stateVersion = 4;

  # Configure Nixpkgs repository settings
  nixpkgs = {
    # Set the host platform to ARM64 macOS
    hostPlatform = "aarch64-darwin";
    config = {
      # Allow unfree packages
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };

  # Install Meslo Nerd Font
  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "Meslo" ]; })
  ];

  # Set the home directory for the user
  users.users.${user}.home = "/users/${user}";

  # Enable Touch ID authentication for sudo
  security.pam.enableSudoTouchIdAuth = true;

  # Enable Zsh as a login shell
  programs.zsh.enable = true;

  # Configure environment settings
  environment = {
    # Set available shells
    shells = with pkgs; [ bash zsh ];
    # Set default login shell to Zsh
    loginShell = pkgs.zsh;
    # Install coreutils package
    systemPackages = [ pkgs.coreutils ];
  };

  # Configure custom user preferences for various applications
  system.defaults.CustomUserPreferences = {
    # Finder settings
    "com.apple.finder" = {
      "NSWindowTabbingShoudShowTabBarKey-com.apple.finder.TBrowserWindow" = true;
    };

    # Safari settings
    "com.apple.Safari" = {
      AlwaysShowTabBar = true;
      ShowStatusBar = true;
      IncludeDevelopMenu = true;
    };
    "com.apple.Safari.SandboxBroker" = {
      ShowDevelopMenu = true;
    };

    # Dock settings
    "com.apple.dock" = {
      expose-group-apps = true;
    };

    # Control Center settings
    "com.apple.controlcenter" = {
      BatteryShowPercentage = true;
    };

    # Terminal settings
    "com.apple.Terminal" = {
      NSWindowTabbingShoudShowTabBarKey-TTWindow-TTWindowController-TTWindowController-VT-FS = true;
    };

    # Function key usage settings
    "com.apple.HIToolbox" = {
      AppleFnUsageType = 2;
    };

    # Disable Music song notifications
    "com.apple.Music" = {
      userWantsPlaybackNotifications = false;
    };
  };

  # Configure system-wide defaults
  system.defaults = {
    # Finder defaults
    finder = {
      FXPreferredViewStyle = "clmv";
      ShowPathbar = true;
      ShowStatusBar = true;
    };

    # Dock defaults
    dock = {
      magnification = true;
      tilesize = 30;
      largesize = 60;
      minimize-to-application = true;
      wvous-bl-corner = 1;
      wvous-br-corner = 1;
      wvous-tl-corner = 1;
      wvous-tr-corner = 1;
      # Set persistent apps in the Dock
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

  # Configure Homebrew
  homebrew = {
    enable = true;
    # Clean up on activation
    onActivation.cleanup = "zap";
    # Install cask applications
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
