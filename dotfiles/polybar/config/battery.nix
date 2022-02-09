{
  "module/battery" = {
    type = "internal/battery";

    full-at = 99;

    #Use the following command to list batteries and adapters:
    #   ls -1 /sys/class/power_supply/
    battery = "BAT0";
    adapter = "AC";

    # Available tags:
    #   <label-charging> (default)
    #   <bar-capacity>
    #   <ramp-capacity>
    #   <animation-charging>
    format-charging = "<animation-charging>  <label-charging>";

    # Available tags:
    #   <label-discharging> (default)
    #   <bar-capacity>
    #   <ramp-capacity>
    #   <animation-discharging>
    format-discharging = "<ramp-capacity>  <label-discharging>";

    # Available tags:
    #   <label-full> (default)
    #   <bar-capacity>
    #   <ramp-capacity>
    format-full = "<ramp-capacity>  <label-full>";

    # Available tokens:
    #   %percentage% (default) - is set to 100 if full-at is reached
    #   %percentage_raw%
    #   %time%
    #   %consumption% (shows current charge rate in watts)
    label-charging = "%percentage%%";

    # Available tokens:
    #   %percentage% (default) - is set to 100 if full-at is reached
    #   %percentage_raw%
    #   %time%
    #   %consumption% (shows current discharge rate in watts)
    label-discharging = "%percentage%%";

    # Available tokens:
    #   %percentage% (default) - is set to 100 if full-at is reached
    #   %percentage_raw%
    label-full = "%percentage%%";

    # Only applies if <ramp-capacity> is used
    ramp-capacity-0 = "";
    ramp-capacity-1 = "";
    ramp-capacity-2 = "";
    ramp-capacity-3 = "";
    ramp-capacity-4 = "";

    # Only applies if <animation-charging> is used
    animation-charging-0 = "";
    animation-charging-1 = "";
    animation-charging-2 = "";
    animation-charging-3 = "";
    animation-charging-4 = "";

    # Framerate in milliseconds
    animation-charging-framerate = 750;

    ramp-capacity-0-foreground = "\${colors.red}";
  };
}
