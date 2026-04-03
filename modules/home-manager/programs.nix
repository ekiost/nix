{ pkgs, ... }:
{
  home.file.".config/zed/settings.json".source = ./zed.json;

  programs = {
    zsh = {
      enable = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      shellAliases = {
        config-switch = "sudo darwin-rebuild switch --flake ~/.config/nix";
        config-update = "nix flake update --flake ~/.config/nix";
      };
      initContent = ''
        source ${pkgs.zsh-fzf-tab}/share/fzf-tab/fzf-tab.plugin.zsh
      '';
    };

    oh-my-posh = {
      enable = true;
      settings = builtins.fromJSON (builtins.readFile ./oh-my-posh.json);
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
      enableZshIntegration = true;
      nix-direnv.enable = true;
      silent = true;
    };
  };
}
