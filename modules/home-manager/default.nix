{ pkgs, ... }:
{
  home.stateVersion = "25.05";

  home.packages = with pkgs; [
    colima
    coreutils
    discord
    docker
    fastfetch
    mos
    nil
    nixd
    nixfmt-rfc-style
    speedtest-cli
    telegram-desktop
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
      useTheme = "tokyonight_storm";
    };

    git = {
      enable = true;
      userName = "ekiost";
      userEmail = "choonkeatling@icloud.com";
      ignores = [
        ".DS_Store"
        ".vscode"
        ".idea"
      ];
      extraConfig = {
        init.defaultBranch = "main";
        push.autoSetupRemote = true;
      };
    };

    direnv = {
      enable = true;
    };

    zed-editor = {
      enable = true;
      extensions = [ "nix" ];
      userSettings = {
        assistant = {
          default_model = {
            provider = "zed.dev";
            model = "claude-3-5-sonnet-latest";
          };
          version = "2";
        };
        base_keymap = "VSCode";
        ui_font_size = 16;
        buffer_font_size = 16;
        theme = {
          mode = "system";
          light = "One Light";
          dark = "Tokyo Night";
        };
        terminal = {
          font_family = "MesloLGL Nerd Font";
        };
        lsp = {
          nil = {
            settings = {
              formatting = {
                command = [ "nixfmt" ];
              };
            };
          };
        };
      };
    };
  };
}
