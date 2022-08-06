{ config, ... }:

let
  shadow = import ../../shadow.nix;
  secrets = config.sops.secrets;
  host = config.network.hostName;
  extInterface = config.network.vlan;
  peers = [ "laptop" "pc" "phone" "pasha" "anjela" "p" "p_p" "m" "m_p" "m_pa" "k_1" "m_1" ];
  publicKeys = {
    laptop = "LN9KwNKWs5Ee+1qQK79U8Dev6bmcqfKk85ZqmMY44Gw=";  #2
    pc = "xmxoj6Tj8Ht/cxqDqpYPE3rpvLG5jdQM4YuXBgw8gFE=";      #3
    phone = "5+lRCZuyDQR+OqfaySWoth63im7MIWnf+BfHrizWKRY=";   #4
    pasha = "34/337i5pBBUomfizp8X3D8vs0e8KvWkixr48jcq0S8=";   #5
    anjela = "eyE6xE3GTnyMFjJ9chuEOPeon/jgTSf03Ghk5RRuaFw=";  #6
    p = "/faeUA3akkTDWJ4vrjUNMO+Th4Qn/HHLVxypijRAzxM=";       #7
    p_p = "kX/sO+U98RTbUeVdZULzbouz/ZfpsmLrCOvDS6ER3S0=";     #8
    m = "vyxxjGjzxHcsySefkgLuHvKlAodGj7otlOZaDw76Wyo=";       #9
    m_p = "QEL0a4hwOzyyytj/Yp4wy/DBL7BaaLXXhPCHXfzXxWY=";     #10
    m_pa = "oMcpPh81mlHwaRHJltE5Kgexa8KDVllp97i9y2KPPW8=";    #11
    k_1 = "SjO9vwyroy2qSRsdWCQlrLWS5fbvlAHAnttJv3t0ClU=";     #12
    m_1 = "r5Ep+fSH7TWtFUA7z57FDnKoPLzZnxMOSvJExM8xGGc=";     #13
  };
in
{
  imports = [
    ./module/server.nix
  ];

  wireguard.server = {
    inherit extInterface;

    port = shadow.${host}.wgPort;
    privateKey = secrets."wireguard/${host}/private".path;
    peers =
      map
        (peer: {
          publicKey = publicKeys.${peer};
          presharedKey = secrets."wireguard/${peer}/common".path;
        })
        peers;
  };

  sops.secrets = {
    "wireguard/${host}/private" = { };
    "wireguard/pc/common" = { };
    "wireguard/laptop/common" = { };
    "wireguard/phone/common" = { };
    "wireguard/pasha/common" = { };
    "wireguard/anjela/common" = { };
    "wireguard/p/common" = { };
    "wireguard/p_p/common" = { };
    "wireguard/m/common" = { };
    "wireguard/m_p/common" = { };
    "wireguard/m_pa/common" = { };
    "wireguard/k_1/common" = { };
    "wireguard/m_1/common" = { };
  };

}
