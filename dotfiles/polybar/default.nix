{ config, pkgs, lib, ... }:

let
  config = import ./config/config.nix;
  colors = import ./config/colors.nix;
  xmonad = import ./config/xmonad.nix { inherit pkgs; };
  xkeyboard = import ./config/xkeyboard.nix;
  date = import ./config/date.nix;
  wifi = import ./config/wifi.nix { inherit pkgs; };
  pulseaudio = import ./config/pulseaudio.nix { inherit pkgs; };
  backlight = import ./config/backlight.nix;
  battery = import ./config/battery.nix;
  powermenu = import ./config/powermenu.nix { inherit pkgs; };

  wifiInterface = pkgs.callPackage ./script/get-wifi.nix { };
  backlightCard = pkgs.callPackage ./script/get-backlight.nix { };
in
{
  config = {
    services.polybar = {
      enable = true;
      package = pkgs.polybarFull;
      settings = config // colors // xmonad // xkeyboard // date // wifi // battery // pulseaudio // backlight // battery // powermenu;
      script = ''
        export WIFI_INTERFACE=$(${wifiInterface}/bin/get-wifi)
        export BACKLIGHT_CARD=$(${backlightCard}/bin/get-backlight)
        polybar top&
      '';
    };
    # disable polybar as a service due to some clickable actions not working properly
    # manage via xsession instead
    systemd.user.services.polybar = lib.mkForce { };
  };
}
