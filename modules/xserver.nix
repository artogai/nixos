{ config, pkgs, lib, ... }:
{
  options = {
    hardware.gpu = lib.mkOption {
      type = lib.types.enum [ "amd" "nvidia" ];
    };
    hardware.touchpad.enable = lib.mkEnableOption "touchpad";
  };

  config = lib.mkMerge [
    {
      services.xserver = {
        enable = true;
        layout = "us,ru";
        xkbOptions = "grp:caps_toggle";
        useGlamor = true;

        libinput = {
          enable = true;
          touchpad = lib.mkIf config.hardware.touchpad.enable {
            tapping = true;
            disableWhileTyping = true;
          };
        };
      };

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
    (lib.mkIf (config.hardware.gpu == "amd") {
      boot.initrd.kernelModules = [ "amdgpu" ];
      services.xserver.videoDrivers = [ "amdgpu" ];

      hardware.opengl.extraPackages = with pkgs; [
        rocm-opencl-icd
        rocm-opencl-runtime
        amdvlk
      ];

      hardware.opengl.extraPackages32 = with pkgs; [
        driversi686Linux.amdvlk
      ];

      # remove after bios update 1.13
      boot.kernelParams = [ "iommu=soft" ];
    })
    (lib.mkIf (config.hardware.gpu == "nvidia")
      (
        let
          nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
            export __NV_PRIME_RENDER_OFFLOAD=1
            export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
            export __GLX_VENDOR_LIBRARY_NAME=nvidia
            export __VK_LAYER_NV_optimus=NVIDIA_only
            exec -a "$0" "$@"
          '';
        in
        {

          services.xserver.videoDrivers = [ "nvidia" ];
          #environment.systemPackages = [ nvidia-offload ];

          #hardware.nvidia.prime = {
          #  offload.enable = lib.mkDefault true;
          #};
        }
      ))
  ];
}
