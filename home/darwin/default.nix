{ pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    claude-code
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

    zed-editor = {
      enable = true;
      package = lib.mkForce null;
      extensions = [
        "catppuccin"
        "catppuccin-icons"
      ];
      userSettings = {
        "icon_theme" = {
          "mode" = "dark";
          "light" = "Catppuccin Macchiato";
          "dark" = "Catppuccin Macchiato";
        };
        "agent_servers" = {
          "claude-acp" = {
            "type" = "registry";
          };
        };
        "base_keymap" = "VSCode";
        "ui_font_size" = 16;
        "buffer_font_size" = 15;
        "theme" = {
          "mode" = "system";
          "light" = "Catppuccin Latte";
          "dark" = "Catppuccin Macchiato";
        };
        "format_on_save" = "on";
        "autosave" = "on_focus_change";
        "restore_on_startup" = "launchpad";
      };
    };
  };

  services.podman.enable = true;
}
