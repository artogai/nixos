{ config, lib, ... }:

let
  inherit (lib) mkOption types;

  cfg = config.openvpn.client;

  client = protocol: port: {
    autoStart = false;
    config =
      (import ./config/client.nix)
        protocol
        cfg.host
        port
        cfg.ca
        cfg.cert
        cfg.key
        cfg.tlsCrypt;
  };
in
{

  options = {
    openvpn.client = with types; mkOption {
      type = submodule {
        options = {
          host = mkOption {
            type = str;
          };
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
          tlsCrypt = mkOption {
            type = path;
          };
        };
      };
    };
  };

  config = {
    services.openvpn.servers = {
      "${cfg.host}-udp" = client "udp" cfg.port;
      "${cfg.host}-tcp" = client "tcp" cfg.tcpPort;
    };
  };
}
