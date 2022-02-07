{
  programs.dconf.enable = true;
  systemd.services.upower.enable = true;

  services = {
    gnome.gnome-keyring.enable = true;
    upower.enable = true;

    xserver = {
      enable = true;

      displayManager.defaultSession = "none+xmonad";

      windowManager.xmonad = {
        enable = true;
        enableContribAndExtras = true;
      };
    };
  };
}
