{ config, lib, ... }:
let
  inherit (lib) mkOption types;

  cfg = config.wireguard.client;
in
{
  options = {
    wireguard.client = with types; mkOption {
      type = submodule {
        options = {
          port = mkOption {
            type = int;
          };
          privateKey = mkOption {
            type = path;
          };
          subnet = mkOption {
            type = listOf str;
          };
          serverHost = mkOption {
            type = str;
          };
          serverPublicKey = mkOption {
            type = str;
          };
          presharedKey = mkOption {
            type = path;
          };
        };
      };
    };
  };

  config.networking = {
    firewall.allowedUDPPorts = [ cfg.port ];

    wg-quick.interfaces.wg0 = {
      address = cfg.subnet;
      dns = [ "10.100.0.1" "fdc9:281f:04d7:9ee9::1" ];
      privateKeyFile = cfg.privateKey;

      peers = [
        {
          publicKey = cfg.serverPublicKey;
          presharedKeyFile = cfg.presharedKey;
          allowedIPs = [ "0.0.0.0/0" "::/0" ];
          endpoint = "${cfg.serverHost}:${toString cfg.port}";
          persistentKeepalive = 25;
        }
      ];
    };
  };
}
