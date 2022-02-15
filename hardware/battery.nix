{ config, lib, ... }:

with lib;

let
  cfg = config.hardware.power;
in
{
  options = {
    hardware.power = with types; mkOption {
      type = submodule {
        options = {
          battery = mkOption {
            type = nullOr str;
          };
          adapter = mkOption {
            type = nullOr str;
          };
        };
      };
    };
  };

  config = mkIf (!(isNull cfg.battery && isNull cfg.adapter)) {
    assertions = [{
      assertion = !(isNull cfg.adapter || isNull cfg.battery);
      message = "Both battery and adapter should be set";
    }];

    services.upower.enable = true;
    systemd.services.upower.enable = true;

    programs.light.enable = true;

    services.logind.lidSwitch = "suspend-then-hibernate";

    networking.networkmanager.wifi.powersave = true;
  };
}


