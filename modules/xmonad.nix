{
  services = {
    upower.enable = true;

    xserver = {
      enable = true;

      windowManager.xmonad = {
        enable = true;
        enableContribAndExtras = true;
      };
    };

    gnome.gnome-keyring.enable = true;
  };

  programs = {
    seahorse.enable = true;
    dconf.enable = true;
  };

  systemd.services.upower.enable = true;
}
