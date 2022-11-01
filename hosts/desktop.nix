{ config, pkgs, ... }:
let
  shadow = import ../shadow.nix;
in
{
  imports = [
    ./host.nix

    ../system/fonts.nix

    ../hardware/cpu.nix
    ../hardware/gpu.nix
    ../hardware/ssd.nix
    ../hardware/bluetooth.nix
    ../hardware/sound.nix
    ../hardware/printing.nix

    ../graphics/xserver.nix
    ../graphics/xmonad.nix

    ../networking/wireguard/client.nix
    ../networking/openvpn/proton.nix

    ../services/gnupg.nix

    ../nix/flakes.nix
  ];

  users.users.artem.extraGroups = [ "video" "audio" "disk" "networkmanager" "docker" "libvirtd" "adbusers" ];
  virtualisation.docker.enable = true;
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;
  programs.adb.enable = true;

  networking = {
    networkmanager.enable = true;
    hosts = {
      ${shadow.chekhov.ip} = [ "chekhov" ];
    };
  };

  programs.chromium.enable = true;
  programs.steam.enable = true;
  services.gvfs.enable = true;

  systemd.sleep.extraConfig = "HibernateDelaySec=1h";

  environment.extraInit = ''
    unset -v SSH_ASKPASS
  '';

  sops.age.keyFile = "/home/artem/.config/sops/age/keys.txt";
}
