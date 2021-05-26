import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

class UserPosition extends Equatable {

  const UserPosition({
    this.latitude = double.nan,
    this.longitude = double.nan
  });
  
  final double latitude;
  final double longitude;

  static const empty = UserPosition(longitude: double.nan, latitude: double.nan);

  bool get isEmpty => this == UserPosition.empty;

  bool get isNotEmpty => this != UserPosition.empty;

  @override
  List<Object?> get props => [latitude, longitude];

  factory UserPosition.fromJson(Map<String, dynamic> json) {
    return UserPosition(
      latitude: json['latitude'],
      longitude: json['longitude']
    );
  }

  factory UserPosition.fromPosition(Position position) {
    return UserPosition(
      longitude: position.longitude,
      latitude: position.latitude
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude
    };
  }
}