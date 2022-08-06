{ config, lib, ... }:

{
  imports =
    [
      ./hardware.nix
      ../server.nix

      ../../networking/wireguard/server.nix

    ];

  network = {
    hostName = "chekhov";
    vlan = "venet0";
  };

  networking.firewall = {
    allowedTCPPorts = lib.mkForce [ config.openssh.port 53 ];
    allowedUDPPorts = lib.mkForce [ config.wireguard.server.port 53 ];
  };

  users.users.artem.passwordFile = config.sops.secrets."passwords/chekhov".path;
  sops.secrets."passwords/chekhov" = { neededForUsers = true; };

  system.stateVersion = "21.11";
}
