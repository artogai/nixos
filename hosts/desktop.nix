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

    ../services/gnupg.nix

    ../nix/flakes.nix
  ];

  users.users.artem.extraGroups = [ "video" "audio" "disk" "networkmanager" ];

  networking = {
    networkmanager.enable = true;
    hosts = {
      ${shadow.chekhov.ip} = [ "chekhov" ];
      ${shadow.nextcloud.ip} = [ "nextcloud.local" ];
    };
  };

  services.gvfs.enable = true;

  systemd.sleep.extraConfig = "HibernateDelaySec=1h";

  environment.extraInit = ''
    unset -v SSH_ASKPASS
  '';

  sops.age.keyFile = "/home/artem/.config/sops/age/keys.txt";
}
