
import 'dart:async';

import 'package:flutter/services.dart';

class SystemNetworkProxyLinux {
  static const MethodChannel _channel =
      const MethodChannel('system_network_proxy_linux');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
