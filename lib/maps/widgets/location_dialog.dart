import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_counter/models.dart';
import 'package:latlong2/latlong.dart';

class LocationDialog extends StatelessWidget {
  final Problem problem;
  const LocationDialog(this.problem, {super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Information',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Title: ${problem.problemName}'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Description: ${problem.description}'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child:
                Text('Cordinates: ${problem.latitude} : ${problem.longitude}'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Status: ${problem.status}'),
          ),
          SizedBox(width: 300),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              onPressed: () {
                //problem.status = "Completed";
                //Navigator.of(context).pop();
              },
              child: const Text("Mark problem as Completed"),
            ),
          ),
        ],
      ),
    ));
  }
}
