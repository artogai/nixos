{ config, pkgs, lib, ... }:

{
  imports =
    [
      ./vpsadminos.nix
      ../../modules/time.nix
    ];



  networking = {
    hostName = "chekhov";

    useDHCP = false;
    interfaces.venet0.useDHCP = true;

    firewall = {
      enable = true;
      allowedTCPPorts = lib.mkForce [ 30951 ];
      allowedUDPPorts = lib.mkForce [ ];
      allowPing = false;
    };
  };

  users = {
    mutableUsers = false;
    users = {
      artem = {
        uid = 1000;
        isNormalUser = true;
        extraGroups = [ "wheel" ];
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHKmokskRPOx45Iaed6pX2BEHyBjAvBCqrfTY5Z5tClm"
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIt5U3CZ+7d/hPDyUhyEnQxRk8iLJoLosuUj3jvWVRVH"
        ];
        passwordFile = config.sops.secrets."passwords/chekhov".path;
      };
      root.openssh.authorizedKeys.keys = config.users.users.artem.openssh.authorizedKeys.keys;
    };
  };

  services = {
    fail2ban.enable = false;

    openssh = {
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
  };

  environment.defaultPackages = lib.mkForce [ ];

  environment.systemPackages = with pkgs; [
    vim
  ];

  system.stateVersion = "21.11";
}
