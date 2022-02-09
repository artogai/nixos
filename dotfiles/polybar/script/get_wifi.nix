{ pkgs }:
pkgs.writeShellScriptBin "get_wifi" ''
  ls /sys/class/ieee80211/*/device/net/
''
