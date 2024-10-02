import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Fire extends StatelessWidget {
  Fire({super.key});

  final controll = TextEditingController();
  final Stream<QuerySnapshot> usersStream =
      FirebaseFirestore.instance.collection('review').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("C-PARK"),
        backgroundColor: Colors.green,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
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
                      snapshot.data!.docs[index]['review'],
                    ),
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
