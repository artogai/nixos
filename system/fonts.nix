{ pkgs, ... }:
let
  myfonts = pkgs.nerdfonts.override {
    fonts = [
      "JetBrainsMono"
      "Iosevka"
    ];
  };
in
{
  fonts = {
    fontDir.enable = true;
    fonts = with pkgs; [
      myfonts
      font-awesome
    ];
  };
}
