{ ... }:

let
  zedConfig = {
    ui_font_size = 14;
    buffer_font_size = 14;
    theme = {
      mode = "system";
      light = "One Light";
      dark = "One Dark";
    };
    terminal = {
      font_family = "MesloLGL Nerd Font";
    };
    edit_predictions = {
      mode = "subtle";
    };
    load_direnv = "shell_hook";
  };
in
{
  home.file.".config/zed/settings.json".text = builtins.toJSON zedConfig;
}
