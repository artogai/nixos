{
  services.xserver = {
    enable = true;
    layout = "us,ru";
    xkbOptions = "grp:caps_toggle";
    useGlamor = true;

    libinput = {
      enable = true;
      touchpad = {
        tapping = true;
        disableWhileTyping = true;
      };
    };
  };
}
