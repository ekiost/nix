{
  pkgs,
  self,
  user,
  ...
}:
{
  nix.enable = false; # Disable Nix daemon, since it's handled by Determinate

  system = {
    configurationRevision = self.rev or self.dirtyRev or null;
    stateVersion = 5;
    primaryUser = user;
  };

  nixpkgs = {
    hostPlatform = "aarch64-darwin";
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };

  documentation.enable = false;

  users.knownUsers = [ user ];
  users.users.${user} = {
    uid = 501;
    home = "/Users/${user}";
    shell = pkgs.fish;
  };

  programs.fish.enable = true;
}
