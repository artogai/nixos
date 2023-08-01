{ config, pkgs, ... }:
{
  services.betterlockscreen = {
    enable = true;
    arguments = [ "dim" ];
  };

  services.screen-locker.xautolock.enable = false;
  services.xidlehook = {
    enable = true;
    not-when-fullscreen = true;
    not-when-audio = true;
    once = false;

    timers = [
      {
        delay = 15 * 60;
        command = config.services.screen-locker.lockCmd;
      }
      {
        delay = 30 * 60;
        command = "systemctl suspend-then-hibernate";
      }
    ];
  };
}
