{ pkgs, ... }: {
  # Set the state version for home-manager compatibility
  # This is internal compatibility configuration for home-manager, don't change this!
  home.stateVersion = "24.05";

  # Define packages to be installed
  home.packages = with pkgs; [
    colima # Container runtime for macOS
    docker # Containerization platform
    fastfetch # System information tool
    nixpkgs-fmt # Nix code formatter
    speedtest-cli # Internet speed test tool
    dotnet-sdk_8 # .NET SDK 8
    #(python312.withPackages (p: with p; [ jupyter ]))
  ];

  programs = {
    # Zsh configuration
    zsh = {
      enable = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      oh-my-zsh.enable = true;
      oh-my-zsh.plugins = [
      ];
      initExtra = "source ~/.p10k.zsh";
      plugins = [
        {
          name = "powerlevel10k";
          src = pkgs.zsh-powerlevel10k;
          file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
        }
      ];
      shellAliases = {
        config-switch = "darwin-rebuild switch --flake ~/.config/nix";
      };
    };

    # Git configuration
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

    # GitHub CLI configuration
    gh = {
      enable = true;
      extensions = [
        pkgs.gh-dash
      ];
    };

    # Direnv configuration
    direnv = {
      enable = true;
    };
  };

  # Source the Powerlevel10k configuration file
  home.file.".p10k.zsh".source = ./p10k-config/p10k.zsh;
}
