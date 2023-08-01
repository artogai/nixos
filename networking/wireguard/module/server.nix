{ config, pkgs, lib, ... }:
let
  inherit (lib) mkOption types lists;
  inherit (lists) imap1;

  cfg = config.wireguard.server;
in
{
  options.wireguard.server = mkOption {
    type = with types; submodule {
      options = {
        port = mkOption {
          type = int;
        };
        extInterface = mkOption {
          type = str;
        };
        privateKey = mkOption {
          type = path;
        };
        peers = mkOption {
          type = listOf (submodule {
            options = {
              publicKey = mkOption {
                type = str;
              };
              presharedKey = mkOption {
                type = path;
              };
            };
          });
        };
      };
    };
  };


  config = {
    networking.nat = {
      enable = true;
      externalInterface = cfg.extInterface;
      internalInterfaces = [ "wg0" ];
    };

    networking.firewall.trustedInterfaces = [ "wg0" ];

    services.dnsmasq = {
      enable = true;
      settings = {
        interface = "wg0";
      };
    };

    networking.wg-quick.interfaces.wg0 = {
      # Determines the IP address and subnet of the server's end of the tunnel interface.
      address = [ "10.100.0.1/24" "fdc9:281f:04d7:9ee9::1/64" ];

      listenPort = cfg.port;

      privateKeyFile = cfg.privateKey;

      # This allows the wireguard server to route your traffic to the internet and hence be like a VPN
      postUp = ''
        ${pkgs.iptables}/bin/iptables -A FORWARD -i wg0 -j ACCEPT
        ${pkgs.iptables}/bin/iptables -t nat -A POSTROUTING -s 10.100.0.1/24 -o ${cfg.extInterface} -j MASQUERADE
        ${pkgs.iptables}/bin/ip6tables -A FORWARD -i wg0 -j ACCEPT
        ${pkgs.iptables}/bin/ip6tables -t nat -A POSTROUTING -s fdc9:281f:04d7:9ee9::1/64 -o ${cfg.extInterface} -j MASQUERADE
      '';

      # Undo the above
      preDown = ''
        ${pkgs.iptables}/bin/iptables -D FORWARD -i wg0 -j ACCEPT
        ${pkgs.iptables}/bin/iptables -t nat -D POSTROUTING -s 10.100.0.1/24 -o ${cfg.extInterface} -j MASQUERADE
        ${pkgs.iptables}/bin/ip6tables -D FORWARD -i wg0 -j ACCEPT
        ${pkgs.iptables}/bin/ip6tables -t nat -D POSTROUTING -s fdc9:281f:04d7:9ee9::1/64 -o ${cfg.extInterface} -j MASQUERADE
      '';

      peers =
        imap1
          (i: peer:
            let n = toString (i + 1);
            in
            {
              publicKey = peer.publicKey;
              presharedKeyFile = peer.presharedKey;
              allowedIPs = [ "10.100.0.${n}/32" "fdc9:281f:04d7:9ee9::${n}/128" ];
            })
          cfg.peers;
    };
  };
}
