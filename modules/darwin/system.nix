{
  pkgs,
  self,
  user,
  ...
}:
{
  nix.enable = false; # Disable Nix daemon, since is handle by Determinate

  system.configurationRevision = self.rev or self.dirtyRev or null;

  system.stateVersion = 5;

  system.primaryUser = user;

  nixpkgs.hostPlatform = "aarch64-darwin";

  users.users.${user}.home = "/Users/${user}";

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };

  fonts.packages = with pkgs; [ nerd-fonts.meslo-lg ];

  security.pam.services.sudo_local.touchIdAuth = true;
}
