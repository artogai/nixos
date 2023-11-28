{ pkgs, ... }:
{
  imports = [
    ../../dotfiles/keyboard
    ../../dotfiles/git
    ../../dotfiles/xmonad
    ../../dotfiles/themes
  ];

  programs = {
    direnv.enable = true;
    bash.enable = true;
    vscode.enable = true;
  };

  home.packages = with pkgs; [
    alacritty
    libreoffice
    keepassxc
    shutter

    # messangers
    tdesktop

    # browsers
    firefox

    # coding
    kubectl
    kcat
    cachix

    # utils
    fd
    psmisc
    zip
    unzip
  ];

  home.stateVersion = "21.11";
}
