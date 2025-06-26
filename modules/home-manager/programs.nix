{ pkgs, ... }:
{
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
      userName = "ekiost";
      userEmail = "choonkeatling@icloud.com";
      ignores = [
        ".DS_Store"
        ".vscode"
        ".idea"
        ".env*"
      ];
      extraConfig = {
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
