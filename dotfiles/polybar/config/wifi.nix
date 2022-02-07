{ pkgs }:
let
  callDmenu = "${pkgs.networkmanager_dmenu}bin/networkmanager_dmenu";
in
{
  "module/wlan" = {
    type = "internal/network";
    #interface = "\${env:WIFI_INTERFACE}";
    interface = "wlp3s0";
    interval = 3.0;

    format-connected = "<label-connected>";
    format-connected-padding = 0;
    label-connected = "%{A1:${callDmenu}&:}  %essid%%{A}";
    label-connected-padding = 0;

    format-disconnected = "<label-disconnected>";
    format-disconnected-padding = 0;
    label-disconnected = "%{A1:${callDmenu}&:}睊%{A}";
    label-disconnected-padding = 0;
  };
}
