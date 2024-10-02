import 'dart:async';

import 'package:flutter/material.dart';
import 'package:url_launcher_platform_interface/url_launcher_platform_interface.dart';
import 'seeker.dart';

class map extends StatelessWidget {
  const map({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'URL Launcher',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'URL Launcher'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final UrlLauncherPlatform launcher = UrlLauncherPlatform.instance;
  // bool _hasCallSupport = false;
  Future<void>? _launched;

  @override
  void initState() {
    super.initState();

    launcher.canLaunch('tel:123').then((bool result) {
      setState(() {
        // _hasCallSupport = result;
      });
    });
  }

  Future<void> _launchInBrowser(String url) async {
    if (!await launcher.launch(
      url,
      useSafariVC: false,
      useWebView: false,
      enableJavaScript: false,
      enableDomStorage: false,
      universalLinksOnly: false,
      headers: <String, String>{},
    )) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> _launchInWebView(String url) async {
    if (!await launcher.launch(
      url,
      useSafariVC: true,
      useWebView: true,
      enableJavaScript: false,
      enableDomStorage: false,
      universalLinksOnly: false,
      headers: <String, String>{'my_header_key': 'my_header_value'},
    )) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> _launchInWebViewWithJavaScript(String url) async {
    if (!await launcher.launch(
      url,
      useSafariVC: true,
      useWebView: true,
      enableJavaScript: true,
      enableDomStorage: false,
      universalLinksOnly: false,
      headers: <String, String>{},
    )) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> _launchInWebViewWithDomStorage(String url) async {
    if (!await launcher.launch(
      url,
      useSafariVC: true,
      useWebView: true,
      enableJavaScript: false,
      enableDomStorage: true,
      universalLinksOnly: false,
      headers: <String, String>{},
    )) {
      throw Exception('Could not launch $url');
    }
  }

  Widget _launchStatus(BuildContext context, AsyncSnapshot<void> snapshot) {
    if (snapshot.hasError) {
      return Text('Error: ${snapshot.error}');
    } else {
      return const Text('');
    }
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launcher.launch(
      launchUri.toString(),
      useSafariVC: false,
      useWebView: false,
      enableJavaScript: false,
      enableDomStorage: false,
      universalLinksOnly: true,
      headers: <String, String>{},
    );
  }

  @override
  Widget build(BuildContext context) {
    String toLaunch = '$searched';
    return Scaffold(
      appBar: AppBar(
        title: const Text("LOCATION"),
        backgroundColor: Colors.green,
      ),
      body: ListView(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: ElevatedButton(
                  onPressed: () => setState(() {
                    _launched = _launchInBrowser(toLaunch);
                  }),
                  child: const Text('LOCATION'),
                ),
              ),
              const Padding(padding: EdgeInsets.all(16.0)),
              // ElevatedButton(
              //   onPressed: () => setState(() {
              //     _launched = _launchInWebView(toLaunch);
              //   }),
              //   child: const Text('Launch in app'),
              // ),
              const Padding(padding: EdgeInsets.all(16.0)),
              const Padding(padding: EdgeInsets.all(16.0)),
              FutureBuilder<void>(future: _launched, builder: _launchStatus),
            ],
          ),
        ],
      ),
    );
  }
}
