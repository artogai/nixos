{
  "module/backlight" = {
    type = "internal/backlight";
    card = "\${env:BACKLIGHT_CARD}";
    use-actual-brightness = false;
    enable-scroll = true;
    format = "ﯧ  <label>";
    label = "%percentage%%";
  };
}
