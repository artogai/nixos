{ config, ... }:
let
  shadow = import ../../shadow.nix;
  serverHostName = "chekhov";
  clientHostName = config.network.hostName;
in
{
  imports = [
    ./module/client.nix
  ];

  openvpn.client = {
    host = serverHostName;
    port = shadow.${serverHostName}.ovpnPort;
    tcpPort = shadow.${serverHostName}.ovpnTcpPort;
    ca = config.sops.secrets."openvpn/ca".path;
    tlsCrypt = config.sops.secrets."openvpn/tls-crypt".path;
    cert = config.sops.secrets."openvpn/${clientHostName}/cert".path;
    key = config.sops.secrets."openvpn/${clientHostName}/key".path;
  };

  sops.secrets = {
    "openvpn/ca" = { };
    "openvpn/tls-crypt" = { };
    "openvpn/${clientHostName}/cert" = { };
    "openvpn/${clientHostName}/key" = { };
  };
}
