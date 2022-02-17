{ config, ... }:
let
  shadow = import ../shadow.nix;
in
{
  imports = [
    ./host.nix

    ../system/boot-systemd.nix
    ../system/fonts.nix

    ../hardware/cpu.nix
    ../hardware/gpu.nix
    ../hardware/ssd.nix
    ../hardware/bluetooth.nix
    ../hardware/sound.nix
    ../hardware/printing.nix

    ../graphics/xserver.nix
    ../graphics/xmonad.nix

    ../networking/openvpn/proton.nix
    ../networking/openvpn/client.nix

    ../nix/flakes.nix
  ];

  openvpn.client = {
    host = "chekhov";
    port = shadow.chekhov.ovpnPort;
    tcpPort = shadow.chekhov.ovpnTcpPort;
    ca = config.sops.secrets."openvpn/ca".path;
    tlsCrypt = config.sops.secrets."openvpn/tls-crypt".path;
    cert = config.sops.secrets."openvpn/${config.network.hostName}/cert".path;
    key = config.sops.secrets."openvpn/${config.network.hostName}/key".path;
  };

  sops.secrets = {
    "openvpn/ca" = { };
    "openvpn/tls-crypt" = { };
    "openvpn/${config.network.hostName}/cert" = { };
    "openvpn/${config.network.hostName}/key" = { };
  };

  users.users.artem.extraGroups = [ "video" "audio" "disk" "networkmanager" ];

  networking = {
    networkmanager.enable = true;
    hosts = {
      ${shadow.chekhov.ip} = [ "chekhov" ];
    };
  };

  services.gvfs.enable = true;

  sops.age.keyFile = "/home/artem/.config/sops/age/keys.txt";
  programs.gnupg.agent = {
    enable = true;
    pinentryFlavor = "curses";
  };

  systemd.sleep.extraConfig = "HibernateDelaySec=1h";

  environment.extraInit = ''
    unset -v SSH_ASKPASS
  '';
}
