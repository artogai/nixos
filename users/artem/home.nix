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
    chromium
    tdesktop
    keepassxc
    vlc
    transmission-gtk
    discord
    electrum
    evince
    freetube
    shutter
    gnome.cheese

    slack
    dbeaver
    postman
    charles
    docker-compose
    android-studio
    gradle

    #needed or idea
    #wmname LG3D hack
    #todo: find better solution
    wmname

    virt-manager

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

  services.blueman-applet.enable = true;
  services.mpris-proxy.enable = true;

  #https://github.com/nix-community/home-manager/issues/2064
  systemd.user.targets.tray = {
    Unit = {
      Description = "Home Manager System Tray";
      Requires = [ "graphical-session-pre.target" ];
    };
  };

  home.stateVersion = "21.11";
}
