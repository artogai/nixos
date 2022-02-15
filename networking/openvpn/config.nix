{ lib }:

with builtins;
with lib.strings;

let
  servers = country: ports: concatMapStringsSep "\n" (p: "remote " + country + ".protonvpn.com " + (toString p)) ports;
in
{ country, ports, auth-user-pass, ca, tls-auth }:
''client
dev tun
proto udp

${servers country ports}

remote-random
resolv-retry infinite
nobind

# The following setting is only needed for old OpenVPN clients compatibility. New clients
# automatically negotiate the optimal cipher.
cipher AES-256-CBC

auth SHA512
verb 3

setenv CLIENT_CERT 0
tun-mtu 1500
tun-mtu-extra 32
mssfix 1450
persist-key
persist-tun

reneg-sec 0

remote-cert-tls server
auth-user-pass ${auth-user-pass}
pull
fast-io


ca ${ca}

key-direction 1
tls-auth ${tls-auth}
''
