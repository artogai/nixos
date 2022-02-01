{ config, pkgs, lib, ... }:

{
  imports =
    [
      ./vpsadminos.nix
    ];


  time.timeZone = "Europe/Moscow";
  i18n.defaultLocale = "en_US.UTF-8";

  system = {
    autoUpgrade = {
      enable = true;
      allowReboot = true;
      channel = "https://nixos.org/channels/nixos-21.11-small";
    };
  };


  networking = {
    hostName = "vps";
    useDHCP = false;
    interfaces.venet0.useDHCP = true;

    firewall = {
      enable = true;
      allowedTCPPorts = lib.mkForce [ 30951 ];
      allowedUDPPorts = lib.mkForce [];
      allowPing = false;
    };
  };


  users = {
    mutableUsers = false;

    users = {
      vpsadmin = {
        uid = 1000;
        isNormalUser = true;
        extraGroups = [ "wheel" ];
        openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILC+M6MuUQ3rrd+KWw/GRAQHVjeSlQCtXD+teGy8Hecz" ];
        hashedPassword = "";
      };
    };
  };

  services = {
    fail2ban.enable = true;

    openssh = {
      enable = true;
      ports = [ 30951 ];
      openFirewall = false;
      permitRootLogin = "no";
      passwordAuthentication = false;
      allowSFTP = false;
      challengeResponseAuthentication = false;
      extraConfig = ''
        AllowTcpForwarding yes
        X11Forwarding no
        AllowAgentForwarding no
        AllowStreamLocalForwarding no
        AuthenticationMethods publickey
      '';
    };
  };


  environment.defaultPackages = lib.mkForce [];


  environment.systemPackages = with pkgs; [
    vim
  ];


  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.11"; # Did you read the comment?
}
