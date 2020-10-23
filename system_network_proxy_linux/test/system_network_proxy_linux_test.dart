import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:system_network_proxy_linux/system_network_proxy_linux.dart';

void main() {
  const MethodChannel channel = MethodChannel('system_network_proxy_linux');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await SystemNetworkProxyLinux.platformVersion, '42');
  });
}
