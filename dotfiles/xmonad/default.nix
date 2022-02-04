{ pkgs, ... }:
let
  #hdmiExtra = ''
  #  ${pkgs.xorg.xrandr}/bin/xrandr --output HDMI-A-0 --mode 3840x2160 --rate 30.00
  #'';
in
{
  imports = [
    ../polybar
    ../rofi
    ../picom
    ../dunst
  ];

  xsession = {
    enable = true;

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
