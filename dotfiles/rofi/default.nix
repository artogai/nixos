{ pkgs, ... }:
{
  xdg.configFile."networkmanager-dmenu/config.ini".text = ''
    [dmenu]
    dmenu_command = rofi
    rofi_highlight = True
    [editor]
    gui_if_available = True
  '';
  programs.rofi = {
    enable = true;
    terminal = "${pkgs.alacritty}/bin/alacritty";
    theme = "Arc-Dark";
    font = "JetBrainsMono Nerd Font 16";
  };
}
