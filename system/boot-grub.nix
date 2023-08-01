{
  boot.tmp.cleanOnBoot = true;
  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    enableCryptodisk = true;
    device = "nodev";
  };
}
