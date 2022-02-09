{ pkgs }:
{
  "module/powermenu" = {
    type = "custom/text";
    content = "";
    click-left = "${pkgs.rofi}/bin/rofi -show power-menu -modi power-menu:${pkgs.rofi-power-menu}/bin/rofi-power-menu&";
  };
}
