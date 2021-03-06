{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ "dm-snapshot" ];
  boot.kernelModules = [ "acpi_call" "kvm-amd" ];
  boot.extraModulePackages = with config.boot.kernelPackages; [ acpi_call ];

  boot.initrd.luks.devices = {
    crypted = {
      device = "/dev/disk/by-partuuid/6e0a972c-0a49-454e-84db-96f39a5c3a0d";
      allowDiscards = true;
      preLVM = true;
    };
  };

  fileSystems."/" =
    {
      device = "/dev/disk/by-uuid/ad917513-51bc-45be-b6c6-8ffdeaaec1f4";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    {
      device = "/dev/disk/by-uuid/F176-FB1B";
      fsType = "vfat";
    };

  swapDevices =
    [{ device = "/dev/disk/by-uuid/7a2b69f1-771d-407c-a6ac-3215339d6668"; }];

}
