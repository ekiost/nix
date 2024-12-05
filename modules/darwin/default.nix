{ pkgs, user, ... }: {
  services.nix-daemon.enable = true;

  nix.settings.experimental-features = "nix-command flakes";

  nix.settings.auto-optimise-store = true;

  system.stateVersion = 5;

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };

  fonts.packages = with pkgs; [ nerd-fonts.meslo-lg ];

  users.users.${user}.home = "/users/${user}";

  security.pam.enableSudoTouchIdAuth = true;

  system.defaults.CustomUserPreferences = {
    "com.apple.finder" = {
      "NSWindowTabbingShoudShowTabBarKey-com.apple.finder.TBrowserWindow" = true;
      NewWindowTarget = "PfHm";
    };

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

    "com.apple.controlcenter" = {
      BatteryShowPercentage = true;
    };

    "com.apple.Terminal" = {
      NSWindowTabbingShoudShowTabBarKey-TTWindow-TTWindowController-TTWindowController-VT-FS = true;
    };

    "com.apple.HIToolbox" = {
      AppleFnUsageType = 2;
    };

    "com.apple.Music" = {
      userWantsPlaybackNotifications = false;
      losslessEnabled = true;
      preferredDownloadAudioQuality = 15;
      preferredStreamPlaybackAudioQuality = 15;
      preferredDolbyAtmosPlaySetting = 30;
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
      "telegram"
      "visual-studio-code"
    ];
  };
}
