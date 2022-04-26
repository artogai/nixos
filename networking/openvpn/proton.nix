{ config, lib, ... }:

let
  udpPorts = [ 1194 443 5060 4569 80 ];
  tcpPorts = [ 8443 443 5995 ];

  secrets = config.sops.secrets;
  client = protocol: country: {
    autoStart = false;
    updateResolvConf = true;

    config = (
      (import ./config/proton.nix { inherit lib; })
        protocol
        country
        (if protocol == "udp" then udpPorts else tcpPorts)
        secrets."protonvpn/auth-user-pass".path
        secrets."protonvpn/ca".path
        secrets."protonvpn/tls-auth".path
    );
  };
in
{
  sops.secrets = {
    "protonvpn/auth-user-pass" = { };
    "protonvpn/ca" = { };
    "protonvpn/tls-auth" = { };
  };

  services.openvpn.servers = {
    # estonia
    ee-udp = client "udp" "ee";
    ee-tcp = client "tcp" "ee";

    #chechia
    cz-udp = client "udp" "cz";
    cz-tcp = client "tcp" "cz";

    #russia
    ru-udp = client "udp" "ru";
    ru-tcp = client "tcp" "ru";
  };
}
