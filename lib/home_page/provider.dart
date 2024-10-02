import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:newpark/login/login.dart';

String vehicle = '';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: SafeArea(
              child: Column(
        children: [
          const CircleAvatar(
            radius: 50,
            backgroundColor: Colors.blue,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Card(
              color: Colors.green,
              child: ListTile(
                title: const Text("My Profile"),
                trailing: const Icon(Icons.arrow_right_alt_rounded),
                leading: const Icon(Icons.person),
                textColor: Colors.white,
                iconColor: Colors.white,
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (ctx) => const myProfile()));
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Card(
              color: Colors.green,
              child: ListTile(
                title: const Text("Review"),
                trailing: const Icon(Icons.arrow_right_alt_rounded),
                leading: const Icon(Icons.local_parking),
                textColor: Colors.white,
                iconColor: Colors.white,
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (ctx) => const Review()));
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Card(
              color: Colors.green,
              child: ListTile(
                title: const Text("Settings"),
                trailing: const Icon(Icons.arrow_right_alt_rounded),
                leading: const Icon(Icons.person),
                textColor: Colors.white,
                iconColor: Colors.white,
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (ctx) => const settings()));
                },
              ),
            ),
          ),
          ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (ctx) => Login()));
              },
              icon: const Icon(Icons.logout),
              label: const Text("LogOut"))
        ],
      ))),
    );
  }
}

class myProfile extends StatefulWidget {
  const myProfile({super.key});

  @override
  State<myProfile> createState() => _myProfileState();
}

class _myProfileState extends State<myProfile> {
  final TextEditingController _location = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _contact = TextEditingController();
  final TextEditingController _place = TextEditingController();
  final TextEditingController _upi = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final _list = ['Four wheeler/three wheeler', 'two wheeler'];
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Profile"),
        backgroundColor: Colors.green,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _name,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: "NAME"),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _contact,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "ADD CONTACT NUMBER"),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _place,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: "ENTER PLACE"),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _location,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: "ADD LOCATION"),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _upi,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: "ENTER UPI ID"),
              ),
              const SizedBox(
                height: 20,
              ),
              DropdownButtonFormField(
                  decoration:
                      const InputDecoration(hintText: 'Select vehicle type'),
                  items: _list.map((e) {
                    return DropdownMenuItem(value: e, child: Text(e));
                  }).toList(),
                  onChanged: (value) {
                    print(value);
                    vehicle = value!;
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Please select an option';
                    }
                    return null;
                  }),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton.icon(
                  onPressed: () {
                    String location = _location.text;
                    String contact = _contact.text;
                    String name = _name.text;
                    String upi = _upi.text;
                    String place = _place.text;
                    vehicle;
                    saveValue(location, contact, name, upi, place, vehicle);
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) => const ProfileScreen()));
                  },
                  icon: const Icon(Icons.update),
                  label: const Text("update"))
            ],
          ),
        ),
      )),
    );
  }

  Future<void> saveValue(
      String location, contact, name, upi, place, vehicle) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Create a new document with a generated ID
    await firestore.collection('your_collection').add({
      'location': location,
      'name': name,
      'contact': contact,
      'upi': upi,
      'place': place,
      'vehicle': vehicle,
    });
  }
}

class Review extends StatefulWidget {
  const Review({super.key});

  @override
  State<Review> createState() => _landState();
}

class _landState extends State<Review> {
  final _review = TextEditingController();
  final Stream<QuerySnapshot> usersStream =
      FirebaseFirestore.instance.collection('review').snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Review"),
        backgroundColor: Colors.green,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
      ),
      body: Column(
        children: [
          TextFormField(
            controller: _review,
            decoration: const InputDecoration(
                border: OutlineInputBorder(), hintText: "submit your review"),
          ),
          ElevatedButton(
              onPressed: () {
                String revie = _review.text;
                saveValue(revie);
                _review.clear();
              },
              child: Text('submit')),
        ],
      ),
    );
  }

  Future<void> saveValue(String revie) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Create a new document with a generated ID
    await firestore.collection('review').add({
      'review': revie,
    });
  }
}

class notifications extends StatefulWidget {
  const notifications({super.key});

  @override
  State<notifications> createState() => _notificationsState();
}

class _notificationsState extends State<notifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
        backgroundColor: Colors.green,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
      ),
    );
  }
}

class settings extends StatefulWidget {
  const settings({super.key});

  @override
  State<settings> createState() => _settingsState();
}

class _settingsState extends State<settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Settings"),
          backgroundColor: Colors.green,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop(context);
              },
              icon: const Icon(Icons.arrow_back)),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
        ),
        body: SafeArea(
            child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Card(
                color: Colors.green,
                child: ListTile(
                  title: const Text("Help & Support"),
                  trailing: const Icon(Icons.arrow_right_alt_rounded),
                  leading: const Icon(Icons.help_center),
                  textColor: Colors.white,
                  iconColor: Colors.white,
                  onTap: () {},
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Card(
                color: Colors.green,
                child: ListTile(
                  title: const Text("Privacy Policy"),
                  trailing: const Icon(Icons.arrow_right_alt_rounded),
                  leading: const Icon(Icons.notes),
                  textColor: Colors.white,
                  iconColor: Colors.white,
                  onTap: () {},
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Card(
                color: Colors.green,
                child: ListTile(
                    title: const Text("Terms & Conditions"),
                    trailing: const Icon(Icons.arrow_right_alt_rounded),
                    leading: const Icon(Icons.notes),
                    textColor: Colors.white,
                    iconColor: Colors.white,
                    onTap: () {}),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Card(
                color: Colors.green,
                child: ListTile(
                  title: const Text("Security"),
                  trailing: const Icon(Icons.arrow_right_alt_rounded),
                  leading: const Icon(Icons.security),
                  textColor: Colors.white,
                  iconColor: Colors.white,
                  onTap: () {},
                ),
              ),
            ),
          ],
        )));
  }
}
