{ ... }:
{
  system.defaults = {
    CustomUserPreferences = {
      "com.apple.finder" = {
        "NSWindowTabbingShoudShowTabBarKey-com.apple.finder.TBrowserWindow" = true;
      };

      "com.apple.Safari" = {
        AlwaysShowTabBar = true;
        ShowStatusBar = true;
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

    finder = {
      FXPreferredViewStyle = "Nlsv";
      ShowPathbar = true;
      ShowStatusBar = true;
      NewWindowTarget = "Home";
      FXDefaultSearchScope = "SCcf";
      _FXSortFoldersFirst = true;
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
        "/System/Applications/Apps.app"
        "/System/Applications/Messages.app"
        "/System/Applications/FaceTime.app"
        "/Applications/Discord.app"
        "/Applications/Telegram.app"
        "/System/Volumes/Preboot/Cryptexes/App/System/Applications/Safari.app/"
        "/System/Applications/Mail.app"
        "/System/Applications/Maps.app"
        "/System/Applications/Calendar.app"
        "/System/Applications/Photos.app"
        "/System/Applications/Notes.app"
        "/System/Applications/Music.app"
        "/Applications/Zed.app"
        "/System/Applications/Utilities/Terminal.app"
        "/System/Applications/System Settings.app"
      ];
    };

    screencapture = {
      disable-shadow = true;
      include-date = true;
    };
  };

  security.pam.services.sudo_local = {
    touchIdAuth = true;
    watchIdAuth = true;
  };
}
