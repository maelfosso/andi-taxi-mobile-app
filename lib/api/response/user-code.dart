import 'package:json_annotation/json_annotation.dart';

part 'user-code.g.dart';

@JsonSerializable()
class UserCode {

  final String code;
  final String phoneNumber;

  const UserCode({  
    required this.code,
    required this.phoneNumber
  });

  static const empty = UserCode(code: '', phoneNumber: '');

  factory UserCode.fromJson(Map<String, dynamic> json) {
    return UserCode(
      code: json['code'],
      phoneNumber: json['phoneNumber']
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'phoneNumber': phoneNumber
    };
  }
}