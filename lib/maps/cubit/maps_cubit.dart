import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:meta/meta.dart';
import 'package:location/location.dart';
import 'package:latlong2/latlong.dart';

part 'maps_state.dart';

class MapsCubit extends Cubit<MapsState> {
  MapsCubit() : super(MapsInitial());
}
