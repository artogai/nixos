{ config, lib, ... }:

{
  imports =
    [
      ./hardware.nix
      ../server.nix
    ];

  network = {
    hostName = "chekhov";
    vlan = "venet0";
  };

  networking.firewall = {
    allowedTCPPorts = lib.mkForce config.services.openssh.ports;
    allowedUDPPorts = lib.mkForce [ ];
  };

  sops.secrets."passwords/chekhov" = { };
  users.users.artem.passwordFile = config.sops.secrets."passwords/chekhov".path;

  system.stateVersion = "21.11";
}
