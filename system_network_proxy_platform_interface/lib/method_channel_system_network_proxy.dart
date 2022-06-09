import 'dart:async';

import 'package:flutter/services.dart';

import 'system_network_proxy_platform_interface.dart';

const MethodChannel _channel =
    MethodChannel('plugins.flutter.io/system_network_proxy');

/// An implementation of [SystemNetworkProxyPlatform] that uses method channels.
class MethodChannelSystemNetworkProxy extends SystemNetworkProxyPlatform {
  @override
  Future<bool> getProxyEnable() async {
    var result = await _channel.invokeMethod<bool>(
      'getProxyEnable',
    );
    return result ?? false;
  }

  @override
  Future<bool> setProxyEnable(bool proxyEnable) async {
    var result = await _channel.invokeMethod<bool>(
      'setProxyEnable',
      <String, Object>{'proxyEnable': proxyEnable},
    );
    return result ?? false;
  }

  @override
  Future<String> getProxyServer() async {
    var result = await _channel.invokeMethod<String>(
      'getProxyServer',
    );
    return result ?? '';
  }

  @override
  Future<bool> setProxyServer(String proxyServer) async {
    var result = await _channel.invokeMethod<bool>(
      'setProxyServer',
      <String, Object>{'proxyServer': proxyServer},
    );
    return result ?? false;
  }
}
