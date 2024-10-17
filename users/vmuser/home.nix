{ pkgs, ... }:
{
  imports = [
    ../../dotfiles/keyboard
    ../../dotfiles/xmonad
    ../../dotfiles/themes
    ../../dotfiles/syncthing
  ];

  programs = {
    direnv.enable = true;
    bash.enable = true;
    vscode.enable = true;
    alacritty.enable = true;
    firefox.enable = true;
    git.enable = true;
  };

  home.packages = with pkgs; [
    keepassxc
    shutter
    bartib
    tdesktop

    # utils
    psmisc
    zip
    unzip
  ];

  home.stateVersion = "21.11";
}
