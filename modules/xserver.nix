{ pkgs, ... }:
{
  services.xserver = {
    enable = true;
    layout = "us,ru";
    xkbOptions = "grp:win_space_toggle";

    videoDrivers = [ "amdgpu" ];
    useGlamor = true;
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
