{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ "dm-snapshot" ];
  boot.kernelModules = [ "acpi_call" "kvm-amd" ];
  boot.extraModulePackages = with config.boot.kernelPackages; [ acpi_call ];

  boot.initrd.luks.devices = {
    crypted = {
      device = "/dev/disk/by-partuuid/a5b9adf1-111b-4eee-ad53-87eaa6f01dbc";
      allowDiscards = true;
      preLVM = true;
    };
  };

  fileSystems."/" =
    {
      device = "/dev/disk/by-uuid/4c611414-aee7-4b7d-b3c0-58a6441627e4";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    {
      device = "/dev/disk/by-uuid/AFD3-8D2E";
      fsType = "vfat";
    };

  swapDevices =
    [{ device = "/dev/disk/by-uuid/92dacada-1f02-43a3-a8bb-4cc3f1bd08a5"; }];

}
