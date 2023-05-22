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
                maxZoom: 18.45,
                minZoom: 3,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'dev.fleaflet.flutter_map.example',
                ),
                MarkerLayer(
                  markers: _createMarkers(problems),
                ),
                MarkerLayer(
                  markers: [],
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

  List<Marker> _createMarkers(List<Problem> markerDataList) {
    return markerDataList.map((markerData) {
      return Marker(
        width: 60.0,
        height: 60.0,
        point: LatLng(
          double.parse(markerData.latitude),
          double.parse(markerData.longitude),
        ), // Assuming your MarkerData has a LatLng property
        builder: (ctx) => FloatingActionButton(
          child: Text(
            '${markerData.problemId}',
            style: const TextStyle(fontSize: 30),
          ),
          onPressed: () => showDialog(
            context: ctx,
            builder: ((context) => LocationDialog(markerData)),
          ),
        ),
      );
    }).toList();
  }
}
