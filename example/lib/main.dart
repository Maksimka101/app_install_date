import 'package:flutter/material.dart';
import 'dart:async';

import 'package:app_install_date/app_install_date.dart';

void main() {
  runApp(const MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _appInstallDate = 'Unknown';

  @override
  void initState() {
    super.initState();
    _initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> _initPlatformState() async {
    late String installDate;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      final DateTime date = await AppInstallDate().installDate;
      installDate = date.toString();
    } catch (e, st) {
      debugPrint('Failed to load install date due to $e\n$st');
      installDate = 'Failed to load install date';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _appInstallDate = installDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App install date loading example'),
        centerTitle: true,
      ),
      body: Center(
        child: Text('App install date is $_appInstallDate'),
      ),
    );
  }
}
