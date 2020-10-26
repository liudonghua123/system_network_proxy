import 'dart:async';
import 'dart:io';
import 'package:system_network_proxy_platform_interface/system_network_proxy_platform_interface.dart';

class SystemNetworkProxyLinux extends SystemNetworkProxyPlatform {
  static SystemNetworkProxyLinux instance = SystemNetworkProxyLinux();

  static normalizeOutput(String output) {
    return output.trim().replaceAll("'", "");
    // return RegExp(r"^\s*'(?<content>\w+)'\s*$").firstMatch(output)?.namedGroup('content');
  }

  static concatCommands(List<String> commands) {
    return commands.join(' && ');
  }

  /// Returns `true` if this platform is able to getProxyEnable.
  @override
  Future<bool> getProxyEnable() async {
    try {
      var results = await Process.run('bash', [
        '-c',
        concatCommands([
          'gsettings get org.gnome.system.proxy mode',
        ])
      ]);
      print('get proxyEnable, exitCode: ${results.exitCode}, stdout: ${results.stdout}');
      var proxyEnableLine = (results.stdout as String).split('\n').where((item) => item != '').first;
      return normalizeOutput(proxyEnableLine) != 'none';
    } catch (e) {
      print(e);
      return false;
    }
  }

  /// Returns `true` if this platform is able to setProxyEnable [proxyEnable].
  @override
  Future<bool> setProxyEnable(bool proxyEnable) async {
    try {
      var proxyMode = proxyEnable ? 'manual' : 'none';
      var results = await Process.run('bash', [
        '-c',
        concatCommands([
          'gsettings set org.gnome.system.proxy mode $proxyMode',
        ])
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
      var results = await Process.run('bash', [
        '-c',
        concatCommands([
          'gsettings get org.gnome.system.proxy.http host',
          'gsettings get org.gnome.system.proxy.http port',
        ])
      ]);
      print('get proxyServer, exitCode: ${results.exitCode}, stdout: ${results.stdout}');
      var proxyServerLines = (results.stdout as String).split('\n').where((item) => item != '').toList();
      if (normalizeOutput(proxyServerLines[0]) == '') {
        return '';
      }
      return '${normalizeOutput(proxyServerLines[0])}:$proxyServerLines[1]';
    } catch (e) {
      print(e);
      return '';
    }
  }

  /// Returns `true` if this platform is able to setProxyServer [proxyServer].
  @override
  Future<bool> setProxyServer(String proxyServer) async {
    try {
      var match = RegExp(r"^(?:http://)?(?<host>.+):(?<port>\d+)$").firstMatch(proxyServer);
      if (match == null) {
        print('proxyServer parse error!');
        return false;
      }
      var host = match.namedGroup('host');
      var port = match.namedGroup('port');
      var results = await Process.run('bash', [
        '-c',
        concatCommands([
          'gsettings set org.gnome.system.proxy mode manual',
          'gsettings set org.gnome.system.proxy.http enabled true',
          'gsettings set org.gnome.system.proxy.http host ${host}',
          'gsettings set org.gnome.system.proxy.http port ${port}',
          'gsettings set org.gnome.system.proxy use-same-proxy true',
        ])
      ]);
      print('set proxyServer, exitCode: ${results.exitCode}, stdout: ${results.stdout}');
      return results.exitCode == 0;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
