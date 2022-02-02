{ config, lib, pkgs, ... }:
{
  services = {
    gnome.gnome-keyring.enable = true;
    upower.enable = true;

    #dbus = {
    #  enable = true;
    #  packages = [ pkgs.gnome3.dconf ];
    #};

    xserver = {
      enable = true;

      displayManager.defaultSession = "none+xmonad";

      windowManager.xmonad = {
        enable = true;
        enableContribAndExtras = true;
      };

    };
  };

  systemd.services.upower.enable = true;
}
