{ config, lib, ... }:
with builtins;
let
  auth-user-pass = config.sops.secrets."openvnp/home/auth-user-pass".path;
  ca = config.sops.secrets."openvnp/home/ca".path;
  tls-auth = config.sops.secrets."openvnp/home/tls-auth".path;

  makeConfig = import ./config.nix { inherit lib; };
  makeVpn = country: ports: {
    config = makeConfig { inherit country ports auth-user-pass ca tls-auth; };
    autoStart = false;
    updateResolvConf = true;
  };
in
{
  services.openvpn.servers = {
    ee-udp = makeVpn "ee" [ 1194 443 5060 4569 80 ] ; # estonia
  };
}
