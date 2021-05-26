part of 'gmap_cubit.dart';

class GMapState extends Equatable {
  static const LatLng _center = const LatLng(45.521563, -122.677433);
  static MarkerId currentLocationId = MarkerId('current-location');

  GMapState({
    this.currentPosition = _center,
    this.currentPlace = Place.empty,
    this.error = 0,
    this.markers = const {} 
    // Placemark? currentPlacemark
  }); // : this.markers = markers;

  final LatLng currentPosition;
  late final Place currentPlace;
  final int error;
  final Map<MarkerId, Marker> markers; // = <MarkerId, Marker>{};

  @override
  List<Object?> get props => [currentPosition, markers, currentPlace, error];

  GMapState copyWith({
    LatLng? currentPosition,
    Place? currentPlace,
    Map<MarkerId, Marker>? markers,
    int? error
  }) {
    print('COPY WITH ${this.markers}');
    print('COPY WITH ${this.currentPlace}');
    return GMapState(
      currentPosition: currentPosition ?? this.currentPosition,
      currentPlace: currentPlace ?? this.currentPlace,
      markers: markers ?? this.markers,
      error: error ?? this.error,
    );
  }

}

