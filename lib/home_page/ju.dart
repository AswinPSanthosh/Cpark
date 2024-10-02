// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:newpark/seeker/seeker.dart';

String veh = '';

class Vehicle extends StatefulWidget {
  const Vehicle({super.key});

  @override
  State<Vehicle> createState() => _vehicleState();
}

class _vehicleState extends State<Vehicle> {
  final _list = ['Four wheeler/three wheeler', 'two wheeler'];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Scaffold(
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(.0),
              child: Column(
                children: [
                  const Spacer(
                    flex: 20,
                  ),
                  DropdownButtonFormField(
                      decoration: const InputDecoration(
                          hintText: 'Select vehicle type'),
                      items: _list.map((e) {
                        return DropdownMenuItem(value: e, child: Text(e));
                      }).toList(),
                      onChanged: (value) {
                        print(value);
                        veh = value!;
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Please select an option';
                        }
                        return null;
                      }),
                  const Spacer(
                    flex: 1,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (ctx) => Seeker()));
                    },
                    child: const Text('continue'),
                  ),
                  const Spacer(
                    flex: 20,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
