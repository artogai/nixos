{ pkgs, ... }:
{
  imports = [
    ../../dotfiles/git
    ../../dotfiles/xmonad
    ../../dotfiles/themes
  ];

  home.keyboard = {
    layout = "us,ru";
    options = [ "grp:caps_toggle" ];
  };

  programs.java.enable = true;

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

    (jetbrains.idea-community.overrideAttrs (oldAttrs: rec {
      name = "idea-community-${version}";
      version = "2021.3.2";
      src = fetchurl {
        url = "https://download.jetbrains.com/idea/ideaIC-${version}.tar.gz";
        sha256 = "99e2225846d118e3190023abc65c8b2c62a1d1463f601c79a20b9494c54a08c9";
      };
    }))
  ];

  #https://github.com/nix-community/home-manager/issues/2064
  systemd.user.targets.tray = {
    Unit = {
      Description = "Home Manager System Tray";
      Requires = [ "graphical-session-pre.target" ];
    };
  };
}
