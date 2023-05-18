import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_counter/maps/maps.dart';
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
          LatLng latLng = state.currentLocation ?? LatLng(55.5, 8.5);

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
                            ))
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
}

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
