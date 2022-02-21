{ config, lib, ... }:

let
  inherit (lib) mkOption types;

  cfg = config.openvpn.server;

  server = protocol: port: {
    autoStart = true;
    config =
      (import ../config/server.nix)
        protocol
        port
        cfg.ca
        cfg.cert
        cfg.key
        cfg.crl
        cfg.tlsCrypt;
  };
in
{
  options = {
    openvpn.server = with types; mkOption {
      type = submodule {
        options = {
          port = mkOption {
            type = int;
          };
          tcpPort = mkOption {
            type = int;
          };
          ca = mkOption {
            type = path;
          };
          cert = mkOption {
            type = path;
          };
          key = mkOption {
            type = path;
          };
          crl = mkOption {
            type = path;
          };
          tlsCrypt = mkOption {
            type = path;
          };
        };
      };
    };
  };

  config = {
    networking.nat = {
      enable = true;
      externalInterface = config.network.vlan;
      internalInterfaces = [ "tun0" "tun1" ];
    };

    networking.firewall.trustedInterfaces = [ "tun0" "tun1" ];

    services.openvpn.servers = {
      "${config.network.hostName}-udp" = server "udp" cfg.port;
      "${config.network.hostName}-tcp" = server "tcp" cfg.tcpPort;
    };
  };
}
