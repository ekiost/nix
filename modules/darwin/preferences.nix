{ user, ... }:
{
  system = {
    defaults = {
      CustomUserPreferences = {
        "com.apple.finder" = {
          "NSWindowTabbingShoudShowTabBarKey-com.apple.finder.TBrowserWindow" = true;
        };

        "com.apple.Safari" = {
          AlwaysShowTabBar = true;
          ShowStatusBar = true;
        };

        "com.apple.Passwords" = {
          EnableMenuBarExtra = true;
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
          "/System/Volumes/Preboot/Cryptexes/App/System/Applications/Safari.app/"
          "/System/Applications/Mail.app"
          "/System/Applications/Maps.app"
          "/System/Applications/Calendar.app"
          "/System/Applications/Photos.app"
          "/Applications/Photomator.app"
          "/System/Applications/Notes.app"
          "/System/Applications/Music.app"
          "/Applications/Visual Studio Code.app"
          "/System/Applications/Utilities/Terminal.app"
          "/System/Applications/System Settings.app"
        ];
        persistent-others = [
          "/Users/${user}/Downloads"
        ];
      };

      screencapture = {
        disable-shadow = true;
        include-date = true;
      };
    };

    activationScripts.postActivation.text = ''
      echo "Configuring macOS Terminal profile..."

      PROFILE_NAME="Clear Dark JetBrains Mono"
      PROFILE_PATH="/Users/${user}/.config/nix/modules/darwin/Clear Dark JetBrains Mono.terminal"
      CHANGES_MADE=0

      # 1. Check if the profile exists, import if it doesn't
      if ! sudo -u ${user} defaults read com.apple.Terminal "Window Settings" | grep -q "$PROFILE_NAME"; then
          if [ -f "$PROFILE_PATH" ]; then
              echo "Profile not found. Importing $PROFILE_NAME..."
              sudo -u ${user} open -g "$PROFILE_PATH"
              sleep 2
              CHANGES_MADE=1
          else
              echo "Warning: Could not find profile at $PROFILE_PATH"
          fi
      fi

      # 2. Check if it is already the default. If not, set it.
      CURRENT_DEFAULT=$(sudo -u ${user} defaults read com.apple.Terminal "Default Window Settings" 2>/dev/null || echo "")
      if [ "$CURRENT_DEFAULT" != "$PROFILE_NAME" ]; then
          echo "Setting $PROFILE_NAME as the default Terminal profile..."
          sudo -u ${user} defaults write com.apple.Terminal "Default Window Settings" -string "$PROFILE_NAME"
          sudo -u ${user} defaults write com.apple.Terminal "Startup Window Settings" -string "$PROFILE_NAME"
          CHANGES_MADE=1
      fi

      # 3. Only prompt the user if we actually changed something
      if [ $CHANGES_MADE -eq 1 ]; then
          # We use a background process (&) for the AppleScript so it doesn't kill our Nix build
          sudo -u ${user} osascript -e '
            tell application "Terminal"
              activate
              set dialogResult to display dialog "Terminal settings updated.\n\nQuit Terminal to fully apply the new default profile?" buttons {"Keep Open", "Quit Terminal"} default button "Keep Open" with title "Nix-Darwin"
              if button returned of dialogResult is "Quit Terminal" then
                quit
              end if
            end tell
          ' &
      else
          echo "Terminal profile '$PROFILE_NAME' is already installed and set as default. Skipping."
      fi
    '';

  };

  security.pam.services.sudo_local = {
    touchIdAuth = true;
    watchIdAuth = true;
  };
}
