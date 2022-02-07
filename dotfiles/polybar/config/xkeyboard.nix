{
  "module/xkeyboard" = {
    type = "internal/xkeyboard";

    # List of indicators to ignore
    blacklist-0 = "num lock";
    blacklist-1 = "scroll lock";

    # Available tags:
    #   <label-layout> (default)
    #   <label-indicator> (default)
    format = "  <label-layout>";
    format-spacing = 0;

    # Available tokens:
    #   %layout%
    #   %name%
    #   %number%
    #   %icon%
    #   %variant% (unreleased)
    # Default: %layout%
    label-layout = "%layout%";
    label-layout-padding = 0;
  };
}
