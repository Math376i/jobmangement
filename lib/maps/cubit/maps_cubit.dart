import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_counter/jobapi_server.dart';
import 'package:flutter_counter/models.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:meta/meta.dart';
import 'package:location/location.dart';
import 'package:latlong2/latlong.dart';

part 'maps_state.dart';

class MapsCubit extends Cubit<MapsState> {
  MapsCubit() : super(MapsInitial());

  Future<void> getProblems() async {
    emit(MapsLoadingState());
    List<Problem> data = await Server.getProblems(false);
    //await Future.delayed(Duration(seconds: 1));
    emit(MapsLoadedState(data));
  }

  Future<void> getLocation() async {
    //print('Getting location : Todo Later');
  }
}
