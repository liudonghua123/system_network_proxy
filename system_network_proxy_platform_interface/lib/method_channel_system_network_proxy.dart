import 'dart:async';

import 'package:flutter/services.dart';
import 'package:meta/meta.dart' show required;

import 'system_network_proxy_platform_interface.dart';

const MethodChannel _channel = MethodChannel('plugins.flutter.io/system_network_proxy');

/// An implementation of [SystemNetworkProxyPlatform] that uses method channels.
class MethodChannelSystemNetworkProxy extends SystemNetworkProxyPlatform {
  @override
  Future<bool> getProxyEnable() {
    return _channel.invokeMethod<bool>(
      'getProxyEnable',
    );
  }
  @override
  Future<bool> setProxyEnable(bool proxyEnable) {
    return _channel.invokeMethod<bool>(
      'setProxyEnable',
      <String, Object>{'proxyEnable': proxyEnable},
    );
  }
  @override
  Future<String> getProxyServer() {
    return _channel.invokeMethod<String>(
      'getProxyServer',
    );
  }
  @override
  Future<bool> setProxyServer(String proxyServer) {
    return _channel.invokeMethod<bool>(
      'setProxyServer',
      <String, Object>{'proxyServer': proxyServer},
    );
  }
}
