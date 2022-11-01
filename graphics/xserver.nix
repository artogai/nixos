{
  services.xserver = {
    enable = true;
    layout = "us,ru";
    xkbOptions = "grp:caps_toggle";

    libinput = {
      enable = true;
      touchpad = {
        tapping = true;
        disableWhileTyping = true;
      };
    };
  };
}
