{ pkgs, lib, ... }:
{
  environment.systemPackages = with pkgs; [
    vim
    htop
    wget
  ];
}
