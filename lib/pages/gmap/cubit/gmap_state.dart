part of 'gmap_cubit.dart';

class GMapState extends Equatable {
  static const LatLng _center = const LatLng(45.521563, -122.677433);
  static MarkerId currentLocationId = MarkerId('current-location');
  static MarkerId destinationLocationId = MarkerId("destination-location");

  GMapState({
    this.currentPosition = _center,
    this.currentPlace = Place.empty,
    this.error = 0,
    this.markers = const {},
    this.polylines = const {}
    // Placemark? currentPlacemark
  }); // : this.markers = markers;

  final LatLng currentPosition;
  late final Place currentPlace;
  final int error;
  final Map<MarkerId, Marker> markers; // = <MarkerId, Marker>{};
  Map<PolylineId, Polyline> polylines = {};

  @override
  List<Object?> get props => [currentPosition, markers, polylines, currentPlace, error];

  GMapState copyWith({
    LatLng? currentPosition,
    Place? currentPlace,
    Map<MarkerId, Marker>? markers,
    Map<PolylineId, Polyline>? polylines,
    int? error
  }) {
    print('COPY WITH ${this.markers}');
    print('COPY WITH ${this.currentPlace}');
    return GMapState(
      currentPosition: currentPosition ?? this.currentPosition,
      currentPlace: currentPlace ?? this.currentPlace,
      markers: markers ?? this.markers,
      polylines: polylines ?? this.polylines,
      error: error ?? this.error,
    );
  }

  
}

