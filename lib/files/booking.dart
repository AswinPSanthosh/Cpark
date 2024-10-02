import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:newpark/seeker/map.dart';
import 'package:newpark/seeker/payment.dart';
import 'package:newpark/seeker/seeker.dart';
import '../home_page/ju.dart';

String book = "";
String mobileno = "";
String location = "";

class Booking extends StatefulWidget {
  const Booking({super.key});

  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore.instance
        .collection('your_collection')
        .where('place', isEqualTo: searche)
        .where('vehicle', isEqualTo: veh)
        .get()
        .then((QuerySnapshot querySnapshot) {
      setState(() {
        book = querySnapshot.docs.first.id.toString();
        mobileno = querySnapshot.docs.first.get('contact') as String;
        location = querySnapshot.docs.first.get('place') as String;
      });
      print(querySnapshot.docs.first.id.toString());
    });
    return Scaffold(
      body: Center(
        child: SafeArea(
            child: Center(
          child: Column(
            children: [
              Text("Booked at id:$book"),
              Text("Mobile Number is:$mobileno"),
              Text("located at: $location"),
              Text("Parking charge rs 20"),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (ctx) => Payment()));
                  },
                  child: Text('pay'))
            ],
          ),
        )),
      ),
    );
  }
}
