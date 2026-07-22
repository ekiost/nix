{ pkgs, ... }:
{
  home.packages = with pkgs; [
    claude-code
  ];

  programs.fish.shellAliases = {
    config-switch = "sudo nixos-rebuild switch --flake ~/.config/nix#Choon-Keats-NixOS";
  };

  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        normal.family = "JetBrainsMono Nerd Font";
        size = 12;
      };
    };
  };
}
