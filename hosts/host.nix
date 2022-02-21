{ lib, ... }:
{
  imports = [
    ../system/time.nix
    ../system/packages.nix
    ../system/journald.nix

    ../networking/network.nix
    ../networking/firewall.nix

    ../nix/store.nix
    ../nix/sops.nix

    ../users/artem
  ];
}
