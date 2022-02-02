{ config, lib, ... }:
{
  options = {
    bluetooth.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        Enables bluetooth support.
      '';
      };
  };

  config = {
    services.blueman.enable = config.bluetooth.enable;

    hardware.bluetooth = lib.mkIf config.bluetooth.enable {
      enable = true;
      hsphfpd.enable = true;
      settings = {
        General = {
          Enable = "Source,Sink,Media,Socket";
        };
      };
    };
  };
}
