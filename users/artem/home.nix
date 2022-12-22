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
    # apps
    alacritty
    electrum
    freetube
    libreoffice
    gnome.cheese
    keepassxc
    vlc
    transmission-gtk
    shutter
    protonvpn-gui
    bartib


    # messengers
    tdesktop
    element-desktop
    slack

    # browsers
    firefox
    chromium

    # ides
    vscode
    jetbrains.idea-community

    # coding
    sbt
    scala
    gradle
    visualvm
    ghc
    haskellPackages.stylish-haskell
    nixpkgs-fmt
    dbeaver
    postman

    # virtualization
    virt-manager
    docker-compose

    # utils
    fd
    ripgrep
    psmisc
    zip
    unzip
    fuse
    ntfs3g
    sops
    age
    ssh-to-age
    easyrsa
    git-crypt

    # nixos
    deploy-rs.deploy-rs
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
