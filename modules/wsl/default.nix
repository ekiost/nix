{ config, pkgs, user, ... }:

{
  security = {
    sudo.wheelNeedsPassword = true;
    pki.certificateFiles = [
      ./certs/corporate-chain.pem
    ];
  };

  programs = {
    nix-ld.enable = true;
    fish.enable = true;
  };

  environment.systemPackages = [
    pkgs.wget
  ];

  users.extraUsers.ekiost = {
    shell = pkgs.fish;
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "26.05";

  wsl.enable = true;
  wsl.defaultUser = "ekiost";
}
