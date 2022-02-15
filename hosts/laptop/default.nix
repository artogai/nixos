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
    wlan = "wlp28s0";
    eth = "enp27s0";
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
