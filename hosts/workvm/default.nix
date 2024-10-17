{ config, pkgs, ... }:
let
  shadow = import ../../shadow.nix;
in
{
  imports =
    [
      ../desktopvm.nix
      ./hardware.nix
    ];

  networking.hostName = "workvm";

  services.dnsmasq = {
    enable = true;
    settings = {
      server = [
        "1.1.1.1"
        "1.0.0.1"
      ];
    };
  };
  #networking.networkmanager.dns = "none";
  #networking.resolvconf.enable = false;
  #services.resolved.enable = false;

  environment.systemPackages = [ pkgs.wireguard-tools ];

  environment.variables = {
    EDITOR = "code --wait";
    BARTIB_FILE = "\${HOME}/Documents/time.bartib";
  };

  virtualisation.docker.enable = true;

  virtualisation.sharedDirectories = {
    vmshare = {
      source = "//home/artem/VMShare";
      target = "/mnt/shared";
    };
  };

  system.stateVersion = "21.11";
}
