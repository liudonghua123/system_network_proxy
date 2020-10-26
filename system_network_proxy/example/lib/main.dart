import 'package:flutter/material.dart';
import 'package:system_network_proxy/system_network_proxy.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemNetworkProxy.init();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  final proxyServerTextEditingController = TextEditingController(text: 'http://proxy.host:1234');

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    proxyServerTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ScaffoldMessenger(
        key: scaffoldMessengerKey,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('system_network_proxy example app'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: proxyServerTextEditingController,
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RaisedButton(
                      child: Text('getProxyEnable'),
                      onPressed: () async {
                        var proxyEnable = await SystemNetworkProxy.getProxyEnable();
                        scaffoldMessengerKey.currentState.showSnackBar(SnackBar(
                          content: Text('getProxyEnable: $proxyEnable'),
                        ));
                      },
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RaisedButton(
                      child: Text('getProxyServer'),
                      onPressed: () async {
                        var proxyServer = await SystemNetworkProxy.getProxyServer();
                        scaffoldMessengerKey.currentState.showSnackBar(SnackBar(
                          content: Text('getProxyServer: $proxyServer'),
                        ));
                      },
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RaisedButton(
                      child: Text('setProxyEnable'),
                      onPressed: () async {
                        var result =
                            await SystemNetworkProxy.setProxyEnable(!(await SystemNetworkProxy.getProxyEnable()));
                        scaffoldMessengerKey.currentState.showSnackBar(SnackBar(
                          content: Text('setProxyEnable: $result'),
                        ));
                      },
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RaisedButton(
                      child: Text('setProxyServer'),
                      onPressed: () async {
                        var result = await SystemNetworkProxy.setProxyServer(proxyServerTextEditingController.text);
                        scaffoldMessengerKey.currentState.showSnackBar(SnackBar(
                          content: Text('setProxyServer: $result'),
                        ));
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
