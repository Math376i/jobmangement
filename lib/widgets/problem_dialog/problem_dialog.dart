import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_counter/colors.dart';
import 'package:flutter_counter/models.dart';
import 'package:latlong2/latlong.dart';

class ProblemDialog extends StatelessWidget {
  ProblemDialog({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> items = ['important', 'urgent', 'complete', 'status'];
    String _selectedItem = '';
    bool? _useLocation;

    String _title = "";
    String _latitude = "";
    String _longitude = "";
    String _status = "";
    String _description = "";
    String _image = "";

    Problem problem = Problem(
        problemId: 0,
        problemName: _title,
        latitude: _latitude,
        longitude: _longitude,
        description: _description,
        status: _status,
        image: _image);

    return Dialog(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'New Issue',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              width: 350,
              child: Form(
                child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(labelText: "Title"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a title';
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        _title = newValue ?? '';
                      },
                    ),
                    SizedBox(
                      height: 100,
                      child: TextFormField(
                        expands: true,
                        maxLines: null,
                        decoration: const InputDecoration(
                            labelText: 'Enter short description for problem'),
                        validator: (value) {
                          return null;
                        },
                        onSaved: (newValue) {
                          _description = newValue ?? '';
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: ColorDef.company100),
                          onPressed: onPressed,
                          child: const Text(
                            "From Map",
                            style: TextStyle(color: ColorDef.company700),
                          ),
                        ),
                        Row(
                          children: [
                            const Text(
                              "Use Location",
                              style: TextStyle(
                                color: ColorDef.company700,
                              ),
                            ),
                            Checkbox(
                                activeColor: ColorDef.company400,
                                value: _useLocation ?? true,
                                onChanged: (value) {
                                  _useLocation = value ?? false;
                                  print(_useLocation);
                                })
                          ],
                        ),
                      ],
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: ColorDef.company100),
                      onPressed: onPressed,
                      child: const Text(
                        'Add Image of issue',
                        style: TextStyle(
                          color: ColorDef.company700,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              onPressed: () {
                //problem.status = "Completed";
                //Navigator.of(context).pop();
                print(problem);
              },
              child: const Text("Create New"),
            ),
          ),
        ],
      ),
    ));
  }

  void onPressed() {}
}
