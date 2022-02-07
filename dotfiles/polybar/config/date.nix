{
  "module/date" = {
    type = "internal/date";

    # Seconds to sleep between updates
    # Default: 1.0
    interval = 5.0;

    # See "https://en.cppreference.com/w/cpp/io/manip/put_time" for details on how to format the date string
    # NOTE: if you want to use syntax tags here you need to use %%{...}
    date = "%d-%m-%Y";

    # Optional time format
    time = "%H:%M";

    # if `date-alt` or `time-alt` is defined, clicking
    # the module will toggle between formats
    # date-alt = %A, %d %B %Y
    # time-alt = %H:%M:%S

    # Available tags:
    #   <label> (default)
    format = "  <label>";

    # format-background =
    # format-foreground =

    # Available tokens:
    #   %date%
    #   %time%
    # Default: %date%
    label = "%time% %date%";
    label-font = 0;
    #label-foreground =
  };
}
