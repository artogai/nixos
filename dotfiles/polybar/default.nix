{ config, pkgs, ... }:

let
  xmonad = ''
    [module/xmonad]
    type = custom/script
    exec = ${pkgs.xmonad-log}/bin/xmonad-log
    tail = true
  '';

  colors      = builtins.readFile ./colors.ini;
  battery     = builtins.readFile ./battery.ini;
  date        = builtins.readFile ./date.ini;
  xkeyboard   = builtins.readFile ./xkeyboard.ini;
  wlan        = builtins.readFile ./wlan.ini;
  pulseaudio  = builtins.readFile ./pulseaudio.ini;
  powermenu   = builtins.readFile ./powermenu.ini;
in
{
  services.polybar = {
    enable = true;
    package = pkgs.polybarFull;
    config = ./config.ini;
    extraConfig = colors + xmonad + battery + date + xkeyboard + pulseaudio + wlan + powermenu;

    #ignores clicks for some reason
    #polybar started in xmonad/config.hs
    #script = ''polybar top &'';
    script = '''';
  };
}
