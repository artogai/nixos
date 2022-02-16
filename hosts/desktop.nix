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

    ../networking/openvpn

    ../nix/flakes.nix
  ];

  users.users.artem.extraGroups = [ "video" "audio" "disk" "networkmanager" ];
  networking.networkmanager.enable = true;
  systemd.sleep.extraConfig = "HibernateDelaySec=1h";
  sops.age.keyFile = "/home/artem/.config/sops/age/keys.txt";
  services.gvfs.enable = true;

  environment.extraInit = ''
    unset -v SSH_ASKPASS
  '';
}
