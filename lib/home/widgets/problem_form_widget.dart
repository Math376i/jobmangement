import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:latlong2/latlong.dart';

class ProblemFormWidget extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  late final String _name;
  LatLng? _location;
  String? _description;
  String? _status;
  String? _image;
  bool? _useLocation = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Title',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
              onSaved: (value) {
                _name = value ?? '';
              },
            ),
            SizedBox(
              height: 100,
              child: TextFormField(
                expands: true,
                maxLines: null,
                decoration: const InputDecoration(
                    labelText: 'Enter an explanation of the issue.'),
                validator: (value) {
                  return null;
                },
                onSaved: (value) {
                  _description = value ?? '';
                },
              ),
            ),
            CheckboxListTile(
              title: const Text('Use location with this problem?'),
              value: _useLocation,
              onChanged: (value) {
                _useLocation = value ?? true;
              },
            ),
          ],
        ),
      ),
    );
  }
}
