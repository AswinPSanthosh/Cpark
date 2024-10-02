import 'package:flutter/material.dart';
import 'package:newpark/files/booking.dart';
import 'package:newpark/home_page/user_main.dart';

import 'package:newpark/login/login.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    gotoLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'CPARK',
          style: TextStyle(
              color: Colors.blueGrey,
              fontWeight: FontWeight.bold,
              fontSize: 30),
        ),
      ),
    );
  }

  Future<void> gotoLogin() async {
    await Future.delayed(Duration(seconds: 1));
    Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => UserMain()));
  }
}
