{ user, ... }:
{
  services.xremap = {
    enable = true;
    withKDE = true;
    serviceMode = "user";
    userName = user;
    config = {
      keymap = [
        {
          name = "Kitty macOS shortcuts";
          application.only = [ "kitty" ];
          remap = {
            # Copy/paste (Ctrl+Shift avoids SIGINT conflict)
            "Super-c" = "Ctrl-Shift-c";
            "Super-v" = "Ctrl-Shift-v";
            # Tabs
            "Super-t" = "Ctrl-Shift-t";
            "Super-w" = "Ctrl-Shift-q";
            "Super-Shift-RightBrace" = "Ctrl-Shift-Right";
            "Super-Shift-LeftBrace" = "Ctrl-Shift-Left";
            # Windows/panes
            "Super-Enter" = "Ctrl-Shift-Enter";
            "Super-Shift-d" = "Ctrl-Shift-w";
            # Scrollback
            "Super-Up" = "Ctrl-Shift-Up";
            "Super-Down" = "Ctrl-Shift-Down";
            "Super-PageUp" = "Ctrl-Shift-PageUp";
            "Super-PageDown" = "Ctrl-Shift-PageDown";
            "Super-Home" = "Ctrl-Shift-Home";
            "Super-End" = "Ctrl-Shift-End";
            # Font size
            "Super-equal" = "Ctrl-Shift-equal";
            "Super-minus" = "Ctrl-Shift-minus";
            "Super-0" = "Ctrl-Shift-BackSpace";
          };
        }
        {
          name = "macOS-like global shortcuts";
          remap = {
            # Edit
            "Super-c" = "Ctrl-c";
            "Super-v" = "Ctrl-v";
            "Super-x" = "Ctrl-x";
            "Super-z" = "Ctrl-z";
            "Super-Shift-z" = "Ctrl-y";
            "Super-a" = "Ctrl-a";
            "Super-s" = "Ctrl-s";
            "Super-f" = "Ctrl-f";
            "Super-p" = "Ctrl-p";
            # Tabs / windows
            "Super-n" = "Ctrl-n";
            "Super-t" = "Ctrl-t";
            "Super-w" = "Ctrl-w";
            "Super-Shift-t" = "Ctrl-Shift-t";
            "Super-q" = "Alt-F4";
            # Navigation
            "Super-l" = "Ctrl-l";
            "Super-r" = "Ctrl-r";
            # Zoom
            "Super-equal" = "Ctrl-equal";
            "Super-minus" = "Ctrl-minus";
            "Super-0" = "Ctrl-0";
            # Text navigation — Cmd+Arrow maps to line/doc boundaries
            "Super-Left" = "Home";
            "Super-Right" = "End";
            "Super-Up" = "Ctrl-Home";
            "Super-Down" = "Ctrl-End";
            "Super-Shift-Left" = "Shift-Home";
            "Super-Shift-Right" = "Shift-End";
            "Super-Shift-Up" = "Ctrl-Shift-Home";
            "Super-Shift-Down" = "Ctrl-Shift-End";
            # Word navigation — Option+Arrow maps to Ctrl+Arrow
            "Alt-Left" = "Ctrl-Left";
            "Alt-Right" = "Ctrl-Right";
            "Alt-Shift-Left" = "Ctrl-Shift-Left";
            "Alt-Shift-Right" = "Ctrl-Shift-Right";
            "Alt-BackSpace" = "Ctrl-BackSpace";
            "Alt-Delete" = "Ctrl-Delete";
          };
        }
      ];
    };
  };
}
