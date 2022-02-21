{ config, ... }:

let
  shadow = import ../../shadow.nix;
  hostName = config.network.hostName;
in
{
  imports = [
    ./module.nix
  ];

  openssh.port = shadow.${hostName}.sshPort;
}
