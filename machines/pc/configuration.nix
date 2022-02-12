{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix

      ../../modules/boot-systemd.nix
      ../../modules/time.nix
      ../../modules/fonts.nix
      ../../modules/printing.nix
      ../../modules/sound.nix
      ../../modules/bluetooth.nix
      ../../modules/xserver.nix
      ../../modules/xmonad.nix
      ../../modules/nix.nix
      ../../modules/sops.nix
      ../../modules/openvpn
    ];

  users.users.artem = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "audio" "disk" "networkmanager" ];
    uid = 1000;
  };

  networking = {
    hostName = "pc";

    networkmanager.enable = true;

    useDHCP = false;
    interfaces = {
      enp27s0.useDHCP = true;
      wlp28s0.useDHCP = true;
    };

    nameservers = [ "1.1.1.1" ];
  };

  environment.systemPackages = with pkgs; [
    vim
    htop
    wget
    psmisc
  ];

  hardware = {
    gpu = "nvidia";
    cpu.amd.updateMicrocode = true;
    bluetooth.enable = true;
  };

  systemd.sleep.extraConfig = "HibernateDelaySec=1h";

  programs.light.enable = true;
  services.fstrim.enable = true; # enable periodic SSD TRIM of mounted partitions in background.

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "21.11";
}
