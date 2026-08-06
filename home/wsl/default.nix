{ ... }:
{
  programs = {
    fish = {
      enable = true;
      interactiveShellInit = ''
        set -g fish_greeting # Disable greeting
      '';
      shellAliases = {
        config-update = "nix flake update --flake ~/.config/nix";
        config-switch = "sudo nixos-rebuild switch --flake ~/.config/nix#nixos";
      };
    };

    starship = {
      enable = true;
      enableFishIntegration = true;
      enableTransience = true;
    };
  };
}
