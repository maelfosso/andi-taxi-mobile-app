import 'package:andi_taxi/models/place.dart';
import 'package:andi_taxi/models/user_position.dart';
import 'package:equatable/equatable.dart';

class UserPositionPlace extends Equatable {

  const UserPositionPlace({
    this.position = UserPosition.empty,
    this.place = Place.empty,
  });
  
  final UserPosition position;
  final Place place;

  static const empty = UserPositionPlace();

  bool get isEmpty => this == UserPositionPlace.empty;

  bool get isNotEmpty => this != UserPositionPlace.empty;

  @override
  List<Object?> get props => [position, place];

  factory UserPositionPlace.fromJson(Map<String, dynamic> json) {
    return UserPositionPlace(
      position: json['position'],
      place: json['place']
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'position': position,
      'place': place
    };
  }
}