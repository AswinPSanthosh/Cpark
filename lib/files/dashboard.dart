// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newpark/home_page/user_main.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  final email = FirebaseAuth.instance.currentUser!.email;
  final creationTime = FirebaseAuth.instance.currentUser!.metadata.creationTime;
  bool isverified = false;
  User? user = FirebaseAuth.instance.currentUser;

  verifyEmail() async {
    if (user != null && !user!.emailVerified) {
      await user!.sendEmailVerification();
      print('Verification Email has benn sent');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.orangeAccent,
          content: Text(
            'Verification Email has benn sent',
            style: TextStyle(fontSize: 18.0, color: Colors.black),
          ),
        ),
      );
    }
  }

  void initState() {
    super.initState();
    isverified = FirebaseAuth.instance.currentUser!.emailVerified;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Text(
              'User ID: $uid',
              style: const TextStyle(fontSize: 18.0),
            ),
            Row(
              children: [
                Text(
                  'Email: $email',
                  style: const TextStyle(fontSize: 18.0),
                ),
                user!.emailVerified
                    ? userpage()
                    : TextButton(
                        onPressed: () => {verifyEmail()},
                        child: const Text('Verify Email'))
              ],
            ),
          ],
        ),
      ),
    );
  }

  userpage() {
    Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => UserMain()));
  }
}
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: Column(
  //       children: [
  //         Column(
  //           children: [
  //             !user!.emailVerified
  //                 ? ElevatedButton(
  //                     onPressed: () => {verifyEmail()},
  //                     child: Text('Resend Email'))
  //                 : ElevatedButton(onPressed: () {}, child: Text('data'))
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }
//}
