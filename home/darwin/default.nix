{ pkgs, lib, ... }:
{
  imports = [
    ../zed.nix
  ];

  programs = {
    fish.shellAliases = {
      config-switch = "sudo darwin-rebuild switch --flake ~/.config/nix#Choon-Keats-MacBook-Air";
    };

    direnv = {
      enable = true;
      enableFishIntegration = true;
      nix-direnv.enable = true;
      silent = true;
    };

    # Zed itself is installed via Homebrew cask on darwin; only manage its config here.
    zed-editor.package = lib.mkForce null;
  };

  services.podman.enable = true;
}
