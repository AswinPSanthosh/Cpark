import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newpark/home_page/ju.dart';
import 'package:newpark/login/login.dart';
import 'package:newpark/home_page/profile.dart';
import 'provider.dart';

class UserMain extends StatefulWidget {
  UserMain({Key? key}) : super(key: key);

  @override
  _UserMainState createState() => _UserMainState();
}

class _UserMainState extends State<UserMain> {
  int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    const Vehicle(),
    const ProfileScreen(),
    const Verification()
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("C-PARK"),
            ElevatedButton(
              onPressed: () async => {
                await FirebaseAuth.instance.signOut(),
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Login(),
                    ),
                    (route) => false)
              },
              child: const Text('Logout'),
              style: ElevatedButton.styleFrom(foregroundColor: Colors.blueGrey),
            )
          ],
        ),
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Seeker',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'PROVIDER',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.email),
            label: 'Email verification',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.red,
        onTap: _onItemTapped,
      ),
    );
  }
}
