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
        shadow.dns.masq
      ];
    };
  };
  networking.networkmanager.dns = "none";
  networking.resolvconf.enable = false;
  services.resolved.enable = false;

  environment.systemPackages = [ pkgs.wireguard-tools ];

  environment.variables = {
    EDITOR = "code --wait";
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
