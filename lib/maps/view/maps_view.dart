import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_counter/colors.dart';
import 'package:flutter_counter/maps/maps.dart';
import 'package:flutter_counter/maps/widgets/location_dialog.dart';
import 'package:flutter_counter/models.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:location/location.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

class MapsView extends StatelessWidget {
  const MapsView({Key? key}) : super(key: key);

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
          LatLng latLng = state.currentLocation ?? LatLng(55.485831, 8.455615);
          List<Problem> problems = state.data;

          return Scaffold(
            body: FlutterMap(
              options: MapOptions(
                  center: latLng,
                  zoom: 13.0, // Initial zoom level
                  maxZoom: 18.45,
                  minZoom: 3,
                  interactiveFlags: state.interActiveFalgs),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'dev.fleaflet.flutter_map.example',
                ),
                MarkerLayer(
                  markers: _createMarkers(problems),
                ),
                const MarkerLayer(
                  markers: [
                    // TODO: Create a location marker at current location
                  ],
                ),
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
    List<Marker> markers = [];

    for (var markerData in markerDataList) {
      if (markerData.status == 'completed') {
        continue;
      }

      var color = ColorDef.company;
      if (markerData.status == "urgent") {
        color = ColorDef.allert;
      } else if (markerData.status == "important") {
        color = ColorDef.warning;
      } else if (markerData.status == "completed") {
        color = ColorDef.okay;
      }

      Marker marker = Marker(
        width: 60.0,
        height: 60.0,
        point: LatLng(
          double.parse(markerData.latitude),
          double.parse(markerData.longitude),
        ),
        builder: (ctx) => FloatingActionButton(
          backgroundColor: color,
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

      markers.add(marker);
    }

    return markers;
  }
}
