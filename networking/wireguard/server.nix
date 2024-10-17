{ config, ... }:

let
  shadow = import ../../shadow.nix;
  secrets = config.sops.secrets;
  host = config.network.hostName;
  extInterface = config.network.vlan;
  peers = [];
  publicKeys = {};
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
  };

}
