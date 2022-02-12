{ pkgs, ... }:
{
  imports = [
    ../../dotfiles/xmonad
    ../../dotfiles/keyboard
    ../../dotfiles/themes
    ../../dotfiles/git
    ../../dotfiles/java
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
    jetbrains.idea-community
    nixpkgs-fmt

    ghc
    haskellPackages.stylish-haskell

    zip
    unzip
  ];

  #https://github.com/nix-community/home-manager/issues/2064
  systemd.user.targets.tray = {
    Unit = {
      Description = "Home Manager System Tray";
      Requires = [ "graphical-session-pre.target" ];
    };
  };
}
