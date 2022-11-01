{ config, pkgs, ... }:

{
  sops.secrets."nextcloud/password" = {
    owner = config.users.users.nextcloud.name;
  };

  services.nextcloud = {
    enable = true;
    hostName = "nextcloud.local";
    package = pkgs.nextcloud23;
    config = {
      adminuser = "artem";
      adminpassFile = config.sops.secrets."nextcloud/password".path;
    };
  };
}
