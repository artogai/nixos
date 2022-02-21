{ config, lib, ... }:

{
  imports = [
    ./host.nix

    ../networking/firewall.nix
    ../networking/fail2ban.nix
    ../networking/openssh
  ];

  environment.defaultPackages = lib.mkForce [ ];
  users.users.root.openssh.authorizedKeys.keys = config.users.users.artem.openssh.authorizedKeys.keys;
  sops.age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
}
