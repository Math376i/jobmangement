import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_counter/maps/maps.dart';
import 'package:flutter_counter/maps/widgets/location_dialog.dart';
import 'package:flutter_counter/models.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:location/location.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

class MapsView extends StatelessWidget {
  const MapsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapsCubit, MapsState>(
      builder: (context, state) {
        if (state is MapsInitial) {
          BlocProvider.of<MapsCubit>(context).getProblems();
          BlocProvider.of<MapsCubit>(context).getLocation();
          return Container(
            child: LinearProgressIndicator(),
          );
        }
        if (state is MapsLoadedState) {
          LatLng latLng = state.currentLocation ?? LatLng(55.5, 8.5);
          List<Problem> problems = state.data;

          return Scaffold(
            body: FlutterMap(
              options: MapOptions(
                  center: latLng,
                  zoom: 13.0, // Initial zoom level
                  maxZoom: 18.45),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'dev.fleaflet.flutter_map.example',
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      width: 200,
                      height: 200,
                      point: latLng,
                      builder: (context) => GestureDetector(
                        child: const Icon(
                          Icons.location_on_outlined,
                          color: Colors.red,
                        ),
                        onTap: () => showDialog(
                            context: context,
                            builder: (context) => LocationDialog(latLng)),
                      ),
                    ),
                    Marker(
                      width: 30,
                      height: 30,
                      point: LatLng(55.6, 8.4),
                      builder: (ctx) => FloatingActionButton(
                        onPressed: () => showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            Problem problem = problems[0];
                            return Dialog(
                              child: Container(
                                child: Column(
                                  children: [
                                    const Text(
                                      'Information',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                    Text(problem.problemName),
                                    Text('Details: ${problem.description}'),
                                    Text(
                                        'Location: lat ${problem.latitude} - lng ${problem.longitude}'),
                                    Text('${problem.status}'),
                                    OutlinedButton(
                                        style: const ButtonStyle(
                                            backgroundColor:
                                                MaterialStatePropertyAll<Color>(
                                                    Colors.white)),
                                        onPressed: () {
                                          problem.status = 'completed';
                                          print(
                                              'Make it so this updates the single item on the map? And in database');
                                        },
                                        child: const Text(
                                            'Mark Problem as Solved')),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        } else {
          return const Center(
            child: Text('Something Went Wrong'),
          );
        }
      },
    );
  }

  void onPressed() {}
}
