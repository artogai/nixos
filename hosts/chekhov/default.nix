{ config, ... }:

{
  imports =
    [
      ./hardware.nix
      ../server.nix
      ../../services/nextcloud.nix
    ];

  network = {
    hostName = "chekhov";
    vlan = "venet0";
  };

  users.users.artem.passwordFile = config.sops.secrets."passwords/chekhov".path;
  sops.secrets."passwords/chekhov" = { neededForUsers = true; };

  system.stateVersion = "21.11";
}
