part of 'maps_cubit.dart';

@immutable
abstract class MapsState {
  LatLng? currentLocation;
  late final MapController _mapController;

  String? _serviceError = '';

  int interActiveFalgs = InteractiveFlag.rotate |
      InteractiveFlag.pinchMove |
      InteractiveFlag.doubleTapZoom;

  final Location _locationService = Location();

  StreamSubscription<LocationData>? _subscription;
}

class MapsInitial extends MapsState {}

class MapsLoadedState extends MapsState {}
