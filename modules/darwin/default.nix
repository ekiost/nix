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

    # Control Center settings.
    "com.apple.controlcenter" = {
      BatteryShowPercentage = true;
    };

    # Terminal settings.
    "com.apple.Terminal" = {
      NSWindowTabbingShoudShowTabBarKey-TTWindow-TTWindowController-TTWindowController-VT-FS = true;
    };
  };

  system.defaults = {
    finder = {
      FXPreferredViewStyle = "clmv";
      ShowPathbar = true;
      ShowStatusBar = true;
    };
    dock = {
      expose-group-by-app = true;
      magnification = true;
      tilesize = 30;
      largesize = 60;
      minimize-to-application = true;
      # persistent-apps = [
      #   "/Applications/Safari.app"
      #   "/System/Applications/Utilities/Terminal.app"
      # ]
    };
  };

  homebrew = {
    enable = true;
    onActivation.cleanup = "zap";
    casks = [
      "docker"
      "discord"
      "microsoft-word"
      "microsoft-powerpoint"
      "microsoft-excel"
      "mos"
      "telegram"
    ];
  };
}
