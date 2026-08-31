{ pkgs, ... }:
{
  home.packages = with pkgs; [
    claude-code
    fastfetch
    nil
    nixd
    nixfmt
    tree
    wget
  ];
}
