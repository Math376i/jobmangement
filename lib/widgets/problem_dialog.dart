import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_counter/colors.dart';
import 'package:flutter_counter/jobapi_server.dart';
import 'package:flutter_counter/models.dart';
import 'package:latlong2/latlong.dart';

enum SwitchOptions { important, urgent, optional }

class ProblemDialog extends StatefulWidget {
  const ProblemDialog({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ProblemDialogState();
}

class _ProblemDialogState extends State<ProblemDialog> {
  bool _useLocation = false;
  SwitchOptions _selectedOption = SwitchOptions.optional;

  String _title = "";
  String _latitude = "";
  String _longitude = "";
  String _status = "status";
  String _description = "";
  String _image = "";

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Builder(
        builder: (BuildContext context) {
          return SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: IntrinsicHeight(
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
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                    labelText: "Title",
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter a title';
                                    }
                                    return null;
                                  },
                                  onChanged: (newValue) {
                                    setState(() {
                                      _title = newValue!;
                                    });
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  height: 100,
                                  child: TextFormField(
                                    expands: true,
                                    maxLines: null,
                                    decoration: const InputDecoration(
                                      labelText:
                                          'Enter short description for problem',
                                    ),
                                    onChanged: (newValue) {
                                      setState(() {
                                        _description = newValue!;
                                      });
                                    },
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: ColorDef.company100,
                                    ),
                                    onPressed: onPressed,
                                    child: const Text(
                                      "From Map",
                                      style:
                                          TextStyle(color: ColorDef.company700),
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
                                        value: _useLocation ?? false,
                                        onChanged: (value) {
                                          setState(() {
                                            _useLocation = value!;
                                            _longitude = '58.30000';
                                            _latitude = '58.30000';
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              _setLocation(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Status "),
                                  _statusSwitch(),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: ColorDef.company100,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _image = 'https://picsum.photos/400/200';
                                    });
                                  },
                                  child: const Text(
                                    'Add Image of issue',
                                    style: TextStyle(
                                      color: ColorDef.company700,
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  // TODO: Make this open picture in fullscreen??
                                },
                                child: Hero(
                                  tag: 'imageHero',
                                  child: _setImage(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton(
                        onPressed: () async {
                          Problem problem = Problem(
                            problemId: 0,
                            problemName: _title,
                            latitude: _latitude,
                            longitude: _longitude,
                            description: _description,
                            status: _status,
                            image: _image,
                          );
                          await Server.createNewProblem(problem);
                          Navigator.of(context).pop();
                        },
                        child: const Text("Create New"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _setLocation() {
    if (_useLocation == false) {
      return Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: "Latitude",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter latitude';
                  }
                  return null;
                },
                onChanged: (newValue) {
                  setState(() {
                    _latitude = newValue;
                  });
                },
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: "Longitude",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter latitude';
                  }
                  return null;
                },
                onChanged: (newValue) {
                  setState(() {
                    _longitude = newValue;
                  });
                },
              ),
            ),
          ),
        ],
      );
    } else if (_useLocation == true) {
      return Text('Location: $_latitude $_longitude');
    } else {
      return Container();
    }
  }

  Container _setImage() {
    if (_image.isEmpty || _image == '') {
      return Container();
    }
    return Container(
      child: Image.network(
        '$_image',
        width: 400,
        height: 150,
        fit: BoxFit.cover,
      ),
    );
  }

  void onPressed() {}

  Widget _statusSwitch() {
    return SizedBox(
      width: 200,
      child: DropdownButton<SwitchOptions>(
        alignment: AlignmentDirectional.center,
        value: _selectedOption,
        onChanged: (newValue) {
          setState(() {
            _selectedOption = newValue!;
          });
        },
        items: const [
          DropdownMenuItem(
            value: SwitchOptions.optional,
            child: Text('optional'),
          ),
          DropdownMenuItem(
            value: SwitchOptions.urgent,
            child: Text('urgent'),
          ),
          DropdownMenuItem(
            value: SwitchOptions.important,
            child: Text('important'),
          ),
        ],
      ),
    );
  }
}
