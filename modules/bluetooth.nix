{ config, lib, ... }:
let
  cfg = config.bluetooth;
in {
  options = {
    bluetooth.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        Enables bluetooth support.
      '';
      };
  };

  config = lib.mkIf cfg.enable {
    services.blueman.enable = true;

    hardware.bluetooth = {
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
