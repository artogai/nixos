{ pkgs, ... }:
{
  fonts = {
    fontDir.enable = true;
    fonts = with pkgs; [
      dejavu_fonts
      fira-code
      fira-code-symbols
      font-awesome_4
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      liberation_ttf
      mplus-outline-fonts
      dina-font
      proggyfonts
    ];
    fontconfig.defaultFonts.monospace = [ "DejaVu Sans Mono" ];
  };
}
