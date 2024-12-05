{ pkgs, ... }: {
  home.stateVersion = "25.05";

  home.packages = with pkgs; [
    colima
    coreutils
    docker
    fastfetch
    nil
    nixpkgs-fmt
    speedtest-cli
    tree
  ];

  programs = {
    zsh = {
      enable = true;
      oh-my-zsh.enable = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      shellAliases = {
        config-switch = "darwin-rebuild switch --flake ~/.config/nix";
      };
    };

    oh-my-posh = {
      enable = true;
      useTheme = "bubblesextra";
    };

    git = {
      enable = true;
      userName = "ekiost";
      userEmail = "choonkeatling@icloud.com";
      ignores = [ ".DS_Store" ".vscode" ".idea" ];
      extraConfig = {
        init.defaultBranch = "main";
        push.autoSetupRemote = true;
      };
    };

    direnv = {
      enable = true;
    };
  };
}
