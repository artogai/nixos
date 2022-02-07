{ config, pkgs, lib, ... }:

let
  config      = import ./config/config.nix;
  colors      = import ./config/colors.nix;
  xmonad      = import ./config/xmonad.nix { inherit pkgs; };
  xkeyboard   = import ./config/xkeyboard.nix;
  date        = import ./config/date.nix;
  wifi        = import ./config/wifi.nix { inherit pkgs; };
  pulseaudio  = import ./config/pulseaudio.nix { inherit pkgs; };
  battery     = import ./config/battery.nix;
  powermenu   = import ./config/powermenu.nix { inherit pkgs; };

  get_wifi_script     = pkgs.callPackage ./script/get_wifi.nix {};
  get_battery_script  = pkgs.callPackage ./script/get_battery.nix {};
  get_adapter_script  = pkgs.callPackage ./script/get_adapter.nix {};
in
{
  config = {
    services.polybar = {
      enable = true;
      package = pkgs.polybarFull;
      settings = config // colors // xmonad // xkeyboard // date // wifi // battery // pulseaudio // battery // powermenu;
    };
    # disable polybar as a service due to some clickable actions not working properly
    # manage via xsession instead
    systemd.user.services.polybar = lib.mkForce {};
  };

  options = {
    start_polybar = lib.mkOption {
      type = lib.types.lines;
      default = ''
        export WIFI_INTERFACE=$(${get_wifi_script}/bin/get_wifi)
        export BATTERY=$(${get_battery_script}/bin/get_battery)
        export ADAPTER=$(${get_adapter_script}/bin/get_adapter)

        polybar top&
      '';
    };
  };
}
