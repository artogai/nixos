{ pkgs, ... }:
{
  imports = [
    ../../dotfiles/xmonad
    ../../dotfiles/keyboard
    ../../dotfiles/themes
    ../../dotfiles/git
    ../../dotfiles/java
    ../../dotfiles/syncthing
  ];

  home.packages = with pkgs; [
    alacritty
    firefox
    tdesktop
    keepassxc
    vlc
    transmission-gtk
    discord

    sbt
    scala
    visualvm

    vscode
    jetbrains.idea-community
    nixpkgs-fmt

    ghc
    haskellPackages.stylish-haskell

    psmisc
    zip
    unzip

    fuse
    ntfs3g

    deploy-rs.deploy-rs
    sops
    age
    ssh-to-age
    easyrsa
    git-crypt
  ];

  #https://github.com/nix-community/home-manager/issues/2064
  systemd.user.targets.tray = {
    Unit = {
      Description = "Home Manager System Tray";
      Requires = [ "graphical-session-pre.target" ];
    };
  };
}
