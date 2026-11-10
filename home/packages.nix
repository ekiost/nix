{ pkgs, ... }:
{
  home.packages = with pkgs; [
    fastfetch
    nil
    nixd
    nixfmt
    tree
    wget
  ];
}
