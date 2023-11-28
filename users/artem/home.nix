{ pkgs, ... }:
{
  imports = [
    ../../dotfiles/xmonad
    ../../dotfiles/keyboard
    ../../dotfiles/themes
    ../../dotfiles/git
    ../../dotfiles/java
    ../../dotfiles/syncthing
    ../../dotfiles/vscode
  ];

  programs = {
    direnv.enable = true;
    bash.enable = true;
  };

  home.packages = with pkgs; [
    alacritty
    electrum
    libreoffice
    keepassxc
    vlc
    transmission-gtk
    shutter
    bartib
    imagemagick

    # messengers
    tdesktop

    # browsers
    firefox
    chromium

    # ides
    # jetbrains.idea-community

    # coding
    # sbt
    # scala
    # gradle
    # visualvm
    # ghc
    # haskellPackages.stylish-haskell
    # nixpkgs-fmt
    # dbeaver
    # postman
    # terraform
    kubectl
    kcat
    cachix
    nixpkgs-fmt

    # virtualization
    virt-manager
    virt-viewer
    spice
    spice-gtk
    spice-protocol
    virglrenderer

    # docker-compose

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
    wmname
    pandoc
    gsettings-desktop-schemas

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
