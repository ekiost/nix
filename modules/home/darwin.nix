{ pkgs, ... }:
{
  imports = [
    ./prevent-sleep-on-audio.nix
  ];

  home.packages = with pkgs; [
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

    git = {
      settings = {
        user.name = "ekiost";
        user.email = "choonkeatling@icloud.com";
      };
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
