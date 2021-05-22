part of 'gmap_cubit.dart';

class GMapState extends Equatable {
  static const LatLng _center = const LatLng(45.521563, -122.677433);
  static const MarkerId currentLocationId = MarkerId('current-location');

  GMapState({
    this.currentPosition = _center,
    this.error = 0,
    this.markers = const {} }
  ); // : this.markers = markers;

  LatLng currentPosition;
  int error;
  Map<MarkerId, Marker> markers; // = <MarkerId, Marker>{};

  @override
  List<Object?> get props => [currentPosition, error];

  GMapState copyWith({
    LatLng? currentPosition,
    Map<MarkerId, Marker>? markers,
    int? error
  }) {
    print('COPY WITH $markers');
    return GMapState(
      currentPosition: currentPosition ?? this.currentPosition,
      markers: markers ?? this.markers,
      error: error ?? this.error
    );
  }

}