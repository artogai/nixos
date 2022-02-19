{ config, lib, ... }:
let
  shadow = import ../../shadow.nix;
in
{
  imports =
    [
      ./hardware.nix
      ../server.nix
      ../../networking/openvpn/server.nix
      ../../services/nextcloud.nix
    ];

  network = {
    hostName = "chekhov";
    vlan = "venet0";
  };

  networking.firewall = {
    allowedTCPPorts = lib.mkForce [ config.openssh.port config.openvpn.server.tcpPort ];
    allowedUDPPorts = lib.mkForce [ config.openvpn.server.port ];
  };

  openssh.port = shadow.chekhov.sshPort;
  openvpn.server = {
    port = shadow.chekhov.ovpnPort;
    tcpPort = shadow.chekhov.ovpnTcpPort;
    ca = config.sops.secrets."openvpn/ca".path;
    tlsCrypt = config.sops.secrets."openvpn/tls-crypt".path;
    cert = config.sops.secrets."openvpn/chekhov/cert".path;
    key = config.sops.secrets."openvpn/chekhov/key".path;
    crl = config.sops.secrets."openvpn/chekhov/crl".path;
  };

  users.users.artem.passwordFile = config.sops.secrets."passwords/chekhov".path;

  sops.secrets = {
    "passwords/chekhov" = { neededForUsers = true; };
    "openvpn/ca" = { };
    "openvpn/tls-crypt" = { };
    "openvpn/chekhov/cert" = { };
    "openvpn/chekhov/key" = { };
    "openvpn/chekhov/crl" = { };
  };

  system.stateVersion = "21.11";
}
