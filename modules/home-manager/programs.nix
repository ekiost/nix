{ ... }:
{
  programs = {
    fish = {
      enable = true;
      interactiveShellInit = ''
        set -g fish_greeting # Disable greeting
      '';
      shellAliases = {
        config-switch = "sudo darwin-rebuild switch --flake ~/.config/nix";
        config-update = "nix flake update --flake ~/.config/nix";
      };
    };

    starship = {
      enable = true;
      enableFishIntegration = true;
      enableTransience = true;
      presets = [ "nerd-font-symbols" ];
    };

    git = {
      enable = true;
      lfs.enable = true;
      ignores = [
        ".DS_Store"
        ".vscode"
        ".idea"
        ".env*"
      ];
      settings = {
        user.name = "ekiost";
        user.email = "choonkeatling@icloud.com";
        init.defaultBranch = "main";
        push.autoSetupRemote = true;
        core.autocrlf = "input";
      };
    };

    git-credential-oauth.enable = true;

    direnv = {
      enable = true;
      enableFishIntegration = true;
      nix-direnv.enable = true;
      silent = true;
    };
  };
}
