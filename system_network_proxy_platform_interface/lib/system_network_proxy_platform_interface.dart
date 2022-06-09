import 'dart:async';

import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'method_channel_system_network_proxy.dart';

/// The interface that implementations of system_network_proxy must implement.
///
/// Platform implementations should extend this class rather than implement it as `system_network_proxy`
/// does not consider newly added methods to be breaking changes. Extending this class
/// (using `extends`) ensures that the subclass will get the default implementation, while
/// platform implementations that `implements` this interface will be broken by newly added
/// [SystemNetworkProxyPlatform] methods.
abstract class SystemNetworkProxyPlatform extends PlatformInterface {
  /// Constructs a SystemNetworkProxyPlatform.
  SystemNetworkProxyPlatform() : super(token: _token);

  static final Object _token = Object();

  static SystemNetworkProxyPlatform _instance =
      MethodChannelSystemNetworkProxy();

  /// The default instance of [SystemNetworkProxyPlatform] to use.
  ///
  /// Defaults to [MethodChannelSystemNetworkProxy].
  static SystemNetworkProxyPlatform get instance => _instance;

  /// Platform-specific plugins should set this with their own platform-specific
  /// class that extends [SystemNetworkProxyPlatform] when they register themselves.
  // TODO(amirh): Extract common platform interface logic.
  // https://github.com/flutter/flutter/issues/43368
  static set instance(SystemNetworkProxyPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// Returns `true` if this platform is able to getProxyEnable.
  Future<bool> getProxyEnable() {
    throw UnimplementedError('getProxyEnable() has not been implemented.');
  }

  /// Returns `true` if this platform is able to setProxyEnable [proxyEnable].
  Future<bool> setProxyEnable(bool proxyEnable) {
    throw UnimplementedError('setProxyEnable() has not been implemented.');
  }

  /// Returns `true` if this platform is able to getProxyServer.
  Future<String> getProxyServer() {
    throw UnimplementedError('getProxyServer() has not been implemented.');
  }

  /// Returns `true` if this platform is able to setProxyServer [proxyServer].
  Future<bool> setProxyServer(String proxyServer) {
    throw UnimplementedError('setProxyServer() has not been implemented.');
  }
}
