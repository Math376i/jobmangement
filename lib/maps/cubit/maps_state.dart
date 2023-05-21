part of 'maps_cubit.dart';

@immutable
abstract class MapsState {
  LatLng? currentLocation;
  List<Problem>? problemsList;
  late final MapController _mapController;

  int interActiveFalgs = InteractiveFlag.rotate |
      InteractiveFlag.pinchMove |
      InteractiveFlag.doubleTapZoom;

  final Location _locationService = Location();

  StreamSubscription<LocationData>? _subscription;
}

class MapsInitial extends MapsState {}

class MapsLoadedState extends MapsState {
  final List<Problem> data;

  MapsLoadedState(this.data);
}

class MapsLoadingState extends MapsState {}
