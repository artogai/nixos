{ pkgs }:
pkgs.writeShellScriptBin "get-wifi" ''
  ls /sys/class/ieee80211/*/device/net/
''
