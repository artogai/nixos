{ config, lib, ... }:

with lib;

let
  cpuType = config.hardware.cpuType;
in
{
  options = {
    hardware.cpuType = mkOption {
      type = types.enum [ "amd" ];
    };
  };

  config = mkMerge [
    (mkIf (cpuType == "amd") {
      hardware.cpu.amd.updateMicrocode = true;
    })
  ];
}
