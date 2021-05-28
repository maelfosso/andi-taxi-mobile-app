// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user-token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserToken _$UserTokenFromJson(Map<String, dynamic> json) {
  return UserToken(
    user: User.fromJson(json['user'] as Map<String, dynamic>),
    driver: json['driver'] == null
        ? null
        : Driver.fromJson(json['driver'] as Map<String, dynamic>),
    token: json['token'] as String,
  );
}

Map<String, dynamic> _$UserTokenToJson(UserToken instance) => <String, dynamic>{
      'user': instance.user,
      'driver': instance.driver,
      'token': instance.token,
    };
