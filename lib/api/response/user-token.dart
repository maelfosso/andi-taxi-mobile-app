import 'package:andi_taxi/models/models.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user-token.g.dart';

@JsonSerializable()
class UserToken {
  User user;
  String token;

  UserToken({
    required this.user,
    required this.token
  });

  factory UserToken.fromJson(Map<String, dynamic> json) {
    return UserToken(
      user: User.fromJson(json['user']),
      token: json['token']
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(),
      'token': token
    };
  }


}