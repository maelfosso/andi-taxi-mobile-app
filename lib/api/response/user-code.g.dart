// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user-code.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserCode _$UserCodeFromJson(Map<String, dynamic> json) {
  return UserCode(
    code: json['code'] as String,
    phoneNumber: json['phoneNumber'] as String,
  );
}

Map<String, dynamic> _$UserCodeToJson(UserCode instance) => <String, dynamic>{
      'code': instance.code,
      'phoneNumber': instance.phoneNumber,
    };
