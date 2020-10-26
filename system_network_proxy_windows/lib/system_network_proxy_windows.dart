import 'dart:async';
import 'dart:io';

import 'package:system_network_proxy_platform_interface/system_network_proxy_platform_interface.dart';

class SystemNetworkProxyWindows extends SystemNetworkProxyPlatform {
  static SystemNetworkProxyWindows instance = SystemNetworkProxyWindows();

  /// Returns `true` if this platform is able to getProxyEnable.
  @override
  Future<bool> getProxyEnable() async {
    try {
      var results = await Process.run('reg', [
        'query',
        'HKCU\\Software\\Microsoft\\Windows\\CurrentVersion\\Internet Settings',
        '/v',
        'ProxyEnable',
      ]);
      print('get proxyEnable, exitCode: ${results.exitCode}, stdout: ${results.stdout}');
      var proxyEnableLine =
          (results.stdout as String).split('\r\n').where((item) => item.contains('ProxyEnable')).first;
      return proxyEnableLine.substring(proxyEnableLine.length - 1) == '1';
    } catch (e) {
      print(e);
      return false;
    }
  }

  /// Returns `true` if this platform is able to setProxyEnable [proxyEnable].
  @override
  Future<bool> setProxyEnable(bool proxyEnable) async {
    try {
      var results = await Process.run('reg', [
        'add',
        'HKCU\\Software\\Microsoft\\Windows\\CurrentVersion\\Internet Settings',
        '/v',
        'ProxyEnable',
        '/t',
        'REG_DWORD',
        '/f',
        '/d',
        proxyEnable ? '1' : '0',
      ]);
      print('set proxyEnable, exitCode: ${results.exitCode}, stdout: ${results.stdout}');
      return results.exitCode == 0;
    } catch (e) {
      print(e);
      return false;
    }
  }

  /// Returns `true` if this platform is able to getProxyServer.
  @override
  Future<String> getProxyServer() async {
    try {
      var results = await Process.run('reg', [
        'query',
        'HKCU\\Software\\Microsoft\\Windows\\CurrentVersion\\Internet Settings',
        '/v',
        'ProxyServer',
      ]);
      print('get proxyServer, exitCode: ${results.exitCode}, stdout: ${results.stdout}');
      var proxyServerLine =
          (results.stdout as String).split('\r\n').where((item) => item.contains('ProxyServer')).first;
      var proxyServerLineSplits = proxyServerLine.split(RegExp(r"\s+"));
      return proxyServerLineSplits[proxyServerLineSplits.length - 1];
    } catch (e) {
      print(e);
      return '';
    }
  }

  /// Returns `true` if this platform is able to setProxyServer [proxyServer].
  @override
  Future<bool> setProxyServer(String proxyServer) async {
    try {
      var results = await Process.run('reg', [
        'add',
        'HKCU\\Software\\Microsoft\\Windows\\CurrentVersion\\Internet Settings',
        '/v',
        'ProxyServer',
        '/f',
        '/d',
        proxyServer,
      ]);
      print('set proxyServer, exitCode: ${results.exitCode}, stdout: ${results.stdout}');
      return results.exitCode == 0;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
