{
  services.openssh = {
    enable = true;
    ports = [ 30951 ];
    openFirewall = false;
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
}
