{ pkgs, ... }:
{
  services.dunst = {
    enable = true;

    iconTheme = {
      name = "Adwaita-dark";
      package = pkgs.gnome.adwaita-icon-theme;
      size = "16x16";
    };

    settings = {
      global = {
        monitor = 0;
        width = 300;
        height = 50;
        shrink = "yes";
        transparency = 10;
        padding = 16;
        horizontal_padding = 16;
        font = "Jetbrains Mono Font 10";
        line_height = 4;
        format = ''<b>%s</b>\n%b'';
      };
    };
  };
}
