{ config, lib, ... }:

let
  enable = config.hardware.bluetooth.enable;
in
{
  config = lib.mkIf enable {
    hardware.bluetooth = {
      hsphfpd.enable = true;
      settings = {
        General = {
          Enable = "Source,Sink,Media,Socket";
        };
      };
    };
    services.blueman.enable = true;
  };
}
