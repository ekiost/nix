{ ... }:
{
  programs.zed-editor = {
    enable = true;
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
}
