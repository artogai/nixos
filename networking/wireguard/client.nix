{ config, ... }:

let
  shadow = import ../../shadow.nix;
  secrets = config.sops.secrets;
  serverHost = "chekhov";
  serverPublicKey = "iy7aIRigCuR7bM3mr70Han5DxBXcbiXvixb6VPxmMSM=";
  host = config.network.hostName;
  subnets = {
    laptop = "10.100.0.2/24";
    pc = "10.100.0.3/24";
  };
in
{
  imports = [
    ./module/client.nix
  ];

  wireguard.client = {
    inherit serverHost serverPublicKey;

    port = shadow.${serverHost}.wgPort;
    privateKey = secrets."wireguard/${host}/private".path;
    presharedKey = secrets."wireguard/${host}/common".path;
    subnet = subnets.${host};
  };

  sops.secrets = {
    "wireguard/${host}/private" = { };
    "wireguard/${host}/common" = { };
  };
}
