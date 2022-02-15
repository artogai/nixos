{ config, pkgs, lib, ... }:

with lib;

let
  gpuType = config.hardware.gpuType;
in
{
  options = {
    hardware.gpuType = mkOption {
      type = types.enum [ "amd" "nvidia" ];
    };
  };

  config = mkMerge [
    {
      hardware.opengl = {
        enable = true;
        driSupport = true;
        driSupport32Bit = true;

        extraPackages = with pkgs; [
          libvdpau-va-gl
          vaapiVdpau
        ];
      };
    }

    (mkIf (gpuType == "amd")
      {
        boot.initrd.kernelModules = [ "amdgpu" ];
        services.xserver.videoDrivers = [ "amdgpu" ];

        hardware.opengl = {
          extraPackages = with pkgs; [
            rocm-opencl-icd
            rocm-opencl-runtime
            amdvlk
          ];
          extraPackages32 = with pkgs; [
            driversi686Linux.amdvlk
          ];
        };

        # remove after bios update 1.13
        boot.kernelParams = [ "iommu=soft" ];
      })

    (mkIf (gpuType == "nvidia") {
      services.xserver.videoDrivers = [ "nvidia" ];
    })
  ];
}
