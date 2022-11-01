{ config, ... }:

let
  shadow = import ../../shadow.nix;
  hostName = config.network.hostName;
in
{
  imports = [
    ./module/server.nix
  ];

  openvpn.server = {
    port = shadow.${hostName}.ovpnPort;
    tcpPort = shadow.${hostName}.ovpnTcpPort;
    ca = config.sops.secrets."openvpn/ca".path;
    tlsCrypt = config.sops.secrets."openvpn/tls-crypt".path;
    cert = config.sops.secrets."openvpn/${hostName}/cert".path;
    key = config.sops.secrets."openvpn/${hostName}/key".path;
    crl = config.sops.secrets."openvpn/${hostName}/crl".path;
  };

  sops.secrets = {
    "openvpn/ca" = { };
    "openvpn/tls-crypt" = { };
    "openvpn/${hostName}/cert" = { };
    "openvpn/${hostName}/key" = { };
    "openvpn/${hostName}/crl" = { };
  };
}
