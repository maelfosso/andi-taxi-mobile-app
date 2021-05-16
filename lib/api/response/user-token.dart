import 'package:andi_taxi/models/models.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user-token.g.dart';

@JsonSerializable()
class UserToken {
  User user;
  Driver? driver;
  String token;

  UserToken({
    required this.user,
    this.driver,
    required this.token
  });

  factory UserToken.fromJson(Map<String, dynamic> json) {
    return UserToken(
      user: User.fromJson(json['user']),
      driver: Driver.fromJson(json['driver']),
      token: json['token']
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(),
      'driver': driver?.toJson(),
      'token': token
    };
  }


}