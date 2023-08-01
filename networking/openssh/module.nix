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
      openFirewall = false;
      settings =
        {
          PermitRootLogin = "prohibit-password";
          PasswordAuthentication = false;
          KbdInteractiveAuthentication = false;
        };
      allowSFTP = false;
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
