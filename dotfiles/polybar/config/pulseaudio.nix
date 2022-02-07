{ pkgs }:
{
  "module/pulseaudio" = {
    type = "internal/pulseaudio";

    # Sink to be used, if it exists (find using `pacmd list-sinks`, name field)
    # If not, uses default sink
    # sink = alsa_output.pci-0000_12_00.3.analog-stereo

    # Use PA_VOLUME_UI_MAX (~153%) if true, or PA_VOLUME_NORM (100%) if false
    # Default: true
    use-ui-max = true;

    # Interval for volume increase/decrease (in percent points)
    # Default: 5
    interval = 5;

    # Available tags:
    #   <label-volume> (default)
    #   <ramp-volume>
    #   <bar-volume>
    format-volume = "<ramp-volume> <label-volume>";

    # Available tokens:
    #   %percentage% (default)
    #   %decibels%
    label-muted =" ﱝ";

    # Only applies if <ramp-volume> is used
    ramp-volume-0 = "奄";
    ramp-volume-1 = "奄";
    ramp-volume-2 = "奄";

    # Right and Middle click
    click-right = "${pkgs.pavucontrol}/bin/pavucontrol&";
  };
}
