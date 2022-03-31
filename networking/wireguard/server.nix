{ config, ... }:

let
  shadow = import ../../shadow.nix;
  secrets = config.sops.secrets;
  host = config.network.hostName;
  extInterface = config.network.vlan;
  peers = [ "laptop" "pc" "phone" "pasha" "anjela" ];
  publicKeys = {
    laptop = "LN9KwNKWs5Ee+1qQK79U8Dev6bmcqfKk85ZqmMY44Gw=";
    pc = "xmxoj6Tj8Ht/cxqDqpYPE3rpvLG5jdQM4YuXBgw8gFE=";
    phone = "980JfxOTdT2157THkUCJz/WD3O+TxZzD+D48AkSO1lo=";
    pasha = "34/337i5pBBUomfizp8X3D8vs0e8KvWkixr48jcq0S8=";
    anjela = "eyE6xE3GTnyMFjJ9chuEOPeon/jgTSf03Ghk5RRuaFw=";
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
  };

}
