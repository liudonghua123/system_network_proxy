import 'dart:async';
import 'dart:io';

import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:system_network_proxy_platform_interface/system_network_proxy_platform_interface.dart';

class SystemNetworkProxyPlugin extends SystemNetworkProxyPlatform {
  /// Registers this class as the default instance of [UrlLauncherPlatform].
  static void registerWith(Registrar registrar) {
    SystemNetworkProxyPlatform.instance = SystemNetworkProxyPlugin();
  }

  /// Returns `true` if this platform is able to getProxyEnable.
  @override
  Future<bool> getProxyEnable() {
    throw UnimplementedError('getProxyEnable() has not been implemented.');
  }

  /// Returns `true` if this platform is able to setProxyEnable [proxyEnable].
  @override
  Future<bool> setProxyEnable(bool proxyEnable) {
    throw UnimplementedError('setProxyEnable() has not been implemented.');
  }

  /// Returns `true` if this platform is able to getProxyServer.
  @override
  Future<String> getProxyServer() {
    throw UnimplementedError('getProxyServer() has not been implemented.');
  }

  /// Returns `true` if this platform is able to setProxyServer [proxyServer].
  @override
  Future<bool> setProxyServer(String proxyServer) {
    throw UnimplementedError('setProxyServer() has not been implemented.');
  }
}
