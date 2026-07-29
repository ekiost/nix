{ pkgs, ... }:
{
  imports = [
    ./prevent-sleep-on-audio.nix
  ];

  home.packages = with pkgs; [
    nixd
    nixfmt
    docker
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
  };

  services.colima = {
    enable = true;
    profiles.default = {
      isActive = true;
      isService = true;
      setDockerHost = true;
    };
  };
}
