{ pkgs, ... }:
{
  imports = [
    ./plasma.nix
    ../zed.nix
  ];

  programs = {
    fish.shellAliases = {
      config-switch = "sudo nixos-rebuild switch --flake ~/.config/nix#Choon-Keats-NixOS";
    };

    kitty = {
      enable = true;
      settings = {
        tab_bar_edge = "bottom";
        tab_bar_style = "powerline";
        tab_powerline_style = "slanted";
      };
    };
  };
}
