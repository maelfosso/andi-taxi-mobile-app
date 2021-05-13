import 'package:json_annotation/json_annotation.dart';

part 'user-code.g.dart';

@JsonSerializable()
class UserCode {

  String code;
  String phone;

  UserCode({  
    required this.code,
    required this.phone
  });

  factory UserCode.fromJson(Map<String, dynamic> json) {
    return UserCode(
      code: json['code'],
      phone: json['phone']
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'phone': phone
    };
  }
}