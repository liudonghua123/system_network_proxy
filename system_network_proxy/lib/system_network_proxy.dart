import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:system_network_proxy_linux/system_network_proxy_linux.dart';
import 'package:system_network_proxy_macos/system_network_proxy_macos.dart';
import 'package:system_network_proxy_platform_interface/method_channel_system_network_proxy.dart';
import 'package:system_network_proxy_platform_interface/system_network_proxy_platform_interface.dart';
import 'package:system_network_proxy_windows/system_network_proxy_windows.dart';

class SystemNetworkProxy {
  static bool _manualDartRegistrationNeeded = true;
  static init() {
    // This is to manually endorse Dart implementations until automatic
    // registration of Dart plugins is implemented. For details see
    // https://github.com/flutter/flutter/issues/52267.
    if (_manualDartRegistrationNeeded) {
      // Only do the initial registration if it hasn't already been overridden
      // with a non-default instance.
      if (!kIsWeb && SystemNetworkProxyPlatform.instance is MethodChannelSystemNetworkProxy) {
        if (Platform.isMacOS) {
          SystemNetworkProxyPlatform.instance = SystemNetworkProxyMacos();
        } else if (Platform.isLinux) {
          SystemNetworkProxyPlatform.instance = SystemNetworkProxyLinux();
        } else if (Platform.isWindows) {
          SystemNetworkProxyPlatform.instance = SystemNetworkProxyWindows();
        }
      }
      _manualDartRegistrationNeeded = false;
    }
  }

  static Future<bool> getProxyEnable() async {
    return SystemNetworkProxyPlatform.instance.getProxyEnable();
  }

  static Future<bool> setProxyEnable(bool proxyEnable) async {
    return SystemNetworkProxyPlatform.instance.setProxyEnable(proxyEnable);
  }

  static Future<String> getProxyServer() async {
    return SystemNetworkProxyPlatform.instance.getProxyServer();
  }

  static Future<bool> setProxyServer(String proxyServer) async {
    return SystemNetworkProxyPlatform.instance.setProxyServer(proxyServer);
  }
}
