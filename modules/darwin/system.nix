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

  users.knownUsers = [ user ];
  users.users.${user} = {
    uid = 501;
    home = "/Users/${user}";
    shell = pkgs.fish;
  };

  programs.fish.enable = true;

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };

  fonts.packages = with pkgs; [ nerd-fonts.jetbrains-mono ];
}
