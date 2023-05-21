import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

class LocationDialog extends StatelessWidget {
  final LatLng position;
  const LocationDialog(this.position, {super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Center(
        child: Text('Center Text'),
      ),
    );
  }
}
