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

class Place extends Equatable {

  const Place({
    this.country = '',
    this.locality = '',
    this.street = '',
    this.subAdministrativeArea = '',
    this.subLocality = ''
  });
  
  final String street;
  final String country;
  final String locality;
  final String subLocality;
  final String subAdministrativeArea;

  static const empty = Place(
    country: '',
    locality: '',
    subAdministrativeArea: '',
    street: '',
    subLocality: ''
  );

  bool get isEmpty => this == Place.empty;

  bool get isNotEmpty => this != Place.empty;

  @override
  List<Object?> get props => [this.country, this.locality, this.street, this.subLocality, this.subAdministrativeArea];

  factory Place.fromPlacemark(Placemark mark) {
    return Place(
      country: mark.country ?? '',
      street: mark.street ?? '',
      subLocality: mark.subLocality ?? '',
      subAdministrativeArea: mark.subAdministrativeArea ?? '',
      locality: mark.locality ?? ''
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'country': this.country,
      'street': this.street,
      'locality': this.locality,
      'subLocality': this.subLocality,
      'subAdministrativeArea': this.subAdministrativeArea,
    };
  }
  
}