{ config, lib, ... }:

with lib;

let
  cfg = config.network;
  nameservers = [ "1.1.1.1" "2606:4700:4700::1111" ];
  enableDHCP = interface: mkIf (!isNull interface) { networking.interfaces.${interface}.useDHCP = true; };
in
{
  options = {
    network = with types; mkOption {
      type = submodule {
        options = {
          hostName = mkOption {
            type = str;
          };
          wlan = mkOption {
            type = nullOr str;
            default = null;
          };
          eth = mkOption {
            type = nullOr str;
            default = null;
          };
          vlan = mkOption {
            type = nullOr str;
            default = null;
          };
        };
      };
    };
  };

  config = mkMerge [
    {
      assertions =
        [{
          assertion = any (i: !isNull i) [ cfg.wlan cfg.eth cfg.vlan ];
          message = "At least one networking interface should be set";
        }];

      networking = {
        hostName = cfg.hostName;
        useDHCP = false;
        nameservers = nameservers;
      };

      services.resolved = { fallbackDns = nameservers; };
    }
    (enableDHCP cfg.wlan)
    (enableDHCP cfg.eth)
    (enableDHCP cfg.vlan)
  ];
}
