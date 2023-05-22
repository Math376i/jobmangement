import 'package:flutter/material.dart';
import 'package:flutter_counter/models.dart';
import 'package:latlong2/latlong.dart';

class LocationDialog extends StatelessWidget {
  final Problem problem;
  const LocationDialog(this.problem, {super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
        child: Column(
      children: [
        Text('Information'),
        Text('Title: ${problem.problemName}'),
        Text('Description: ${problem.description}'),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("Hello World"),
        ),
      ],
    ));
  }
}
