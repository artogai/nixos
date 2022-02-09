{ config, pkgs, ... }:
{
  imports = [
    ../rofi # window switcher
    ../picom # compositor
    ../dunst # notification manager
    ../polybar # status bar
    ../screen-locker # screen locker
    ../nm-dmenu # networkmanager front end
  ];

  home.packages = with pkgs; with pkgs.gnome; [
    xorg.xrandr # screens configuration
    arandr # frontent for xrandr
    xorg.xmessage # display a message or query in a window

    # pkgs.gnome
    eog # image viewer
    evince # pdf reader
    gnome-calendar # calendar
    xfce.thunar # file manager

    rofi-power-menu # power menu via rofi
    pavucontrol # pulse audio volume control
  ];

  xsession = {
    enable = true;

    initExtra = config.services.polybar.script;

    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
      config = ./config.hs;
      extraPackages = hp: [
        hp.dbus
      ];
    };
  };
}
