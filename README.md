# system_network_proxy

## About

This is a federated plugin which get and set system scoped proxy.

## Implementation details

### windows (**do not need administrator permission** because the operations are only current user scoped)

1. get proxyEnable and proxyServer

   `reg query 'HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings' /v ProxyEnable`

   `reg query 'HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings' /v ProxyServer`

2. set proxyEnable and proxyServer

   set proxyEnable false

   `reg add 'HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings' /v ProxyEnable /t REG_DWORD /f /d 0`

   set proxyEnable true

   `reg add 'HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings' /v ProxyEnable /t REG_DWORD /f /d 1`

   set proxyServer

   `reg add 'HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings' /v ProxyServer /f /d <http://proxy.host:port>`

### linux (**do need root permission for set operations**, currently only support **GNOME 3** desktop which is more widely used in linux world, other desktop like xde maybe support later)

1. get proxyEnable and proxyServer

   `gsettings get org.gnome.system.proxy mode`

   `gsettings get org.gnome.system.proxy.http host`

   `gsettings get org.gnome.system.proxy.http port`

2. set proxyEnable and proxyServer

   set proxyEnable false

   `gsettings set org.gnome.system.proxy mode 'none'`

   set proxyEnable true

   `gsettings set org.gnome.system.proxy mode 'manual'`

   set proxyServer

   `gsettings set org.gnome.system.proxy.http enabled true`

   `gsettings set org.gnome.system.proxy.http host 'proxy.host'`

   `gsettings set org.gnome.system.proxy.http port port`

   `gsettings set org.gnome.system.proxy use-same-proxy true`

### macos (**do NOT need root permission for get/set operations**)

1. get proxyEnable and proxyServer

   `networksetup -getwebproxy wi-fi`

   `networksetup -getsecurewebproxy wi-fi`

2. set proxyEnable and proxyServer

   set proxyEnable false

   `networksetup -setwebproxystate wi-fi off`

   `networksetup -setsecurewebproxystate wi-fi off`

   set proxyEnable true

   `networksetup -setwebproxystate wi-fi on`

   `networksetup -setsecurewebproxystate wi-fi on`

   set proxyServer

   `networksetup -setwebproxy wi-fi 'proxy.host' port`

   `networksetup -setsecurewebproxy wi-fi 'proxy.host' port`

### android

//Todo

### ios

//Todo

### web

//Todo

## Reference, some useful links

- https://flutter.dev/docs/development/packages-and-plugins/developing-packages#plugin
- https://medium.com/flutter/how-to-write-a-flutter-web-plugin-5e26c689ea1
- https://medium.com/flutter/how-to-write-a-flutter-web-plugin-part-2-afdddb69ece6
- https://medium.com/flutter/modern-flutter-plugin-development-4c3ee015cf5a
- https://askubuntu.com/questions/368945/how-to-set-system-wide-proxy-address-using-shell-script
- https://developer.gnome.org/ProxyConfiguration/
- https://superuser.com/questions/316502/how-to-change-proxy-setting-using-command-line-in-mac-os/1297771#1297771
- https://superuser.com/questions/1306849/setting-https-proxies-via-the-terminal
- https://apple.stackexchange.com/questions/226544/how-to-set-proxy-on-os-x-terminal-permanently
