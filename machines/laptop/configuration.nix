{ inputs, config, pkgs, ... }:

{
  imports =
    [ ./hardware-configuration.nix

      ../../modules/boot_efi.nix
      ../../modules/time.nix
      ../../modules/fonts.nix
      ../../modules/printing.nix
      ../../modules/sound.nix
      ../../modules/bluetooth.nix
      ../../modules/xserver.nix
      ../../modules/xmonad.nix
      ../../modules/nix.nix
    ];

  users.users.artem = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    uid = 1000;
  };

  networking = {
    hostName = "laptop";

    networkmanager = {
      enable = true;
      wifi.powersave = true;
    };

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
    psmisc
  ];

  hardware = {
    gpu = "amd";
    cpu.amd.updateMicrocode = true;
    touchpad.enable = true;
    bluetooth.enable = true;
  };

  systemd.sleep.extraConfig = "HibernateDelaySec=1h";

  services = {
    fstrim.enable = true; # enable periodic SSD TRIM of mounted partitions in background.
    logind.lidSwitch = "suspend-then-hibernate";
  };

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "21.11";
}
