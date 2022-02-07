{ pkgs, ... }:
{
  programs.rofi = {
    enable = true;
    terminal = "${pkgs.alacritty}/bin/alacritty";
    theme = "Arc-Dark";
    font = "JetBrainsMono Nerd Font 16";
  };
}
