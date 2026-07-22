{ pkgs, ... }:
{
  programs.fish.shellAliases = {
    config-switch = "sudo nixos-rebuild switch --flake ~/.config/nix#Choon-Keats-NixOS";
  };

programs.kitty = {
    enable = true;
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 12;
    };
    settings = {
      tab_bar_edge = "bottom";
      tab_bar_style = "powerline";
      tab_powerline_style = "slanted";
    };
  };
}
