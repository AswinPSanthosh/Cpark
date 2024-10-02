import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:newpark/files/booking.dart';
import 'package:newpark/seeker/map.dart';
import '../home_page/ju.dart';

String searched = "";
String UPI = '';
String searche = "";

class Seeker extends StatefulWidget {
  const Seeker({Key? key}) : super(key: key);

  @override
  State<Seeker> createState() => _seekerState();
}

class _seekerState extends State<Seeker> {
  TextEditingController seachtf = TextEditingController();

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore.instance
        .collection('your_collection')
        .where('place', isEqualTo: seachtf.text)
        .where('vehicle', isEqualTo: veh)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((DocumentSnapshot doc) {
        searched = doc.get('location') as String;
      });
    });
    FirebaseFirestore.instance
        .collection('your_collection')
        .where('place', isEqualTo: seachtf.text)
        .where('vehicle', isEqualTo: veh)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((DocumentSnapshot doc) {
        UPI = doc.get('upi') as String;
      });
    });
    searche = seachtf.text;
    final Stream<QuerySnapshot> usersStream = FirebaseFirestore.instance
        .collection('your_collection')
        .where(
          'place',
          isEqualTo: seachtf.text,
        )
        .where('vehicle', isEqualTo: veh)
        .snapshots();
    return Scaffold(
      appBar: AppBar(
        title: Container(
          padding: EdgeInsets.only(
            left: 20,
            right: 10,
          ),
          child: TextField(
            controller: seachtf,
            decoration: InputDecoration(
              hintText: 'Search',
            ),
            onChanged: (value) {
              setState(() {});
            },
          ),
        ),
      ),
      body: StreamBuilder(
        stream: usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (_, index) {
                return Card(
                  child: ListTile(
                    title: Text(
                      snapshot.data!.docs[index]['place'],
                    ),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AlertDialog(
                                title: Text(
                                  snapshot.data!.docs[index]['name'],
                                ),
                                content: Column(
                                  children: [
                                    Text("Contact no:"),
                                    Text(
                                      snapshot.data!.docs[index]['contact'],
                                    ),
                                    Text("UPI ID of provider:"),
                                    Text(
                                      snapshot.data!.docs[index]['upi'],
                                    ),
                                  ],
                                ),
                                actions: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (ctx) => map(),
                                        ),
                                      );
                                    },
                                    child: Text('Directions'),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (ctx) => Booking(),
                                        ),
                                      );
                                    },
                                    child: Text('book'),
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
