{ pkgs, ... }:
{
  imports = [
    ../../dotfiles/git
    ../../dotfiles/xmonad
    ../../dotfiles/themes
  ];

  home.packages = with pkgs; [
    alacritty
    firefox
    tdesktop
    keepassxc
    vlc
    transmission
    discord

    sbt
    scala
    visualvm

    vscode
    nixpkgs-fmt

    ghc
    haskellPackages.stylish-haskell

    jetbrains.idea-community
  ];

  programs.java.enable = true;

  home.keyboard = {
    layout = "us,ru";
    options = [ "grp:caps_toggle" ];
  };


  #https://github.com/nix-community/home-manager/issues/2064
  systemd.user.targets.tray = {
    Unit = {
      Description = "Home Manager System Tray";
      Requires = [ "graphical-session-pre.target" ];
    };
  };
}
