{ config, pkgs, ... }:

{
  imports =
    [
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

    bluetooth.enable = false;
  };

  system.stateVersion = "21.11";
}
