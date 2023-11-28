{ config, pkgs, modulesPath, ... }:
{
  imports = [
    (modulesPath + "/virtualisation/qemu-vm.nix")
    ../system/time.nix
    ../system/packages.nix
    ../system/journald.nix
    ../networking/firewall.nix
    ../nix/store.nix
    ../nix/sops.nix
    ../system/fonts.nix
    ../graphics/xserver.nix
    ../graphics/xmonad.nix
    ../nix/flakes.nix

    ../users/vmuser
  ];

  sound = {
    enable = true;
    mediaKeys.enable = true;
  };

  hardware.pulseaudio = {
    enable = true;
    package = pkgs.pulseaudioFull;
  };

  nix.nixPath = [
    "nixpkgs=${pkgs.path}"
  ];

  users.users.vmuser.extraGroups = [ "video" "audio" "disk" "networkmanager" "docker" ];
  networking.networkmanager.enable = true;

  virtualisation.qemu.guestAgent.enable = true;
  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;

  sops.age.keyFile = "/home/artem/.config/sops/age/keys.txt";
}
