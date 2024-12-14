{
  pkgs,
  self,
  user,
  ...
}:
{
  nix.settings.experimental-features = "nix-command flakes";

  system.configurationRevision = self.rev or self.dirtyRev or null;

  system.stateVersion = 5;

  nixpkgs.hostPlatform = "aarch64-darwin";

  users.users.${user}.home = "/Users/${user}";

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };

  fonts.packages = with pkgs; [ nerd-fonts.meslo-lg ];

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

    "com.caldis.Mos" = {
      "hideStatusItem" = 1;
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
        "/Users/${user}/Applications/Home Manager Apps/Telegram.app"
        "/Users/${user}/Applications/Home Manager Apps/Discord.app"
        "/System/Applications/Mail.app"
        "/System/Applications/Maps.app"
        "/System/Applications/Calendar.app"
        "/System/Applications/Photos.app"
        "/System/Applications/Reminders.app"
        "/System/Applications/Notes.app"
        "/Users/${user}/Applications/Home Manager Apps/Zed.app"
        "/System/Applications/Utilities/Terminal.app"
        "/System/Applications/Music.app"
        "/System/Applications/System Settings.app"
      ];
    };
  };
}
