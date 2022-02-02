{ inputs, config, pkgs, ... }:

{
  imports =
    [ ./hardware-configuration.nix

      ../../modules/boot_efi.nix
      ../../modules/time.nix
      ../../modules/fonts.nix
      ../../modules/printing.nix
      ../../modules/sound.nix
      ../../modules/touchpad.nix
      ../../modules/bluetooth.nix
      ../../modules/xserver.nix
      ../../modules/flakes.nix
      ../../modules/auto_gc.nix
    ];

  users.users.artem = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    uid = 1000;
  };

  networking = {
    hostName = "laptop";

    networkmanager.enable = true;

    useDHCP = false;
    interfaces = {
      enp2s0.useDHCP = true;
      wlp3s0.useDHCP = true;
    };

    nameservers = [ "1.1.1.1" ];
  };

  environment.systemPackages = with pkgs; [
    vim
    htop
    wget
    unzip
    git
  ];

  services.logind.lidSwitch = "suspend-then-hibernate";

  services.xserver.desktopManager.gnome.enable = true;

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "21.11";
}
