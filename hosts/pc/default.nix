{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware.nix
      ../desktop.nix
    ];

  network = {
    hostName = "pc";
    wlan = "wlp28s0";
    eth = "enp27s0";
  };

  hardware = {
    cpuType = "amd";
    gpuType = "nvidia";

    bluetooth.enable = false;
  };

  system.stateVersion = "21.11";
}
