{
  pkgs,
  self,
  user,
  ...
}:
{
  nix = {
    settings.experimental-features = "nix-command flakes";
    optimise = {
      automatic = true;
      dates = "weekly";
    };
    gc = {
      automatic = true;
      dates = "weekly";
    };
  };

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
}
