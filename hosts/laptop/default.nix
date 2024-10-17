{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware.nix
      ../desktop.nix
      ../../system/boot-grub.nix
      ../../hardware/battery.nix
    ];

  network = {
    hostName = "laptop";
    wlan = "wlp0s20f3";
    eth = "enp0s31f6";
  };

  hardware = {
    cpuType = "intel";
    gpuType = "intel";

    power = {
      battery = "BAT0";
      adapter = "AC";
    };

    bluetooth.enable = true;
  };

  services.logind.extraConfig = ''
    HandlePowerKey=hibernate
  '';

  system.stateVersion = "23.11";
}
