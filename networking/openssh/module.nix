{ config, lib, ... }:
{
  options = {
    openssh.port = lib.mkOption {
      type = lib.types.int;
    };
  };

  config = {
    services.openssh = {
      enable = true;
      ports = [ config.openssh.port ];
      openFirewall = true;
      permitRootLogin = "prohibit-password";
      passwordAuthentication = false;
      allowSFTP = false;
      kbdInteractiveAuthentication = false;
      extraConfig = ''
        AllowTcpForwarding yes
        X11Forwarding no
        AllowAgentForwarding no
        AllowStreamLocalForwarding no
        AuthenticationMethods publickey
      '';
    };
  };
}
