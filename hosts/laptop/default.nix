{ config, pkgs, ... }:

{
  imports =
    [
      ../../system/boot-grub.nix
      ./hardware.nix
      ../desktop.nix
      ../../hardware/battery.nix
    ];

  network = {
    hostName = "laptop";
    wlan = "wlp3s0";
    eth = "enp2s0";
  };

  hardware = {
    cpuType = "amd";
    gpuType = "amd";

    power = {
      battery = "BAT0";
      adapter = "AC";
    };

    bluetooth.enable = true;
  };

  services.logind.extraConfig = ''
    HandlePowerKey=hibernate
  '';

  system.stateVersion = "21.11";
}
