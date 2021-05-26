import 'package:equatable/equatable.dart';
import 'package:geocoding/geocoding.dart';

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