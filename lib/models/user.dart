import 'package:andi_taxi/models/models.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable {

  const User({
    required this.id,
    this.name,
    this.phoneNumber
  });
  
  final String id;
  final String? name;
  final String? phoneNumber;

  static const empty = User(id: '');

  bool get isEmpty => this == User.empty;

  bool get isNotEmpty => this != User.empty;

  @override
  List<Object?> get props => [id, name, phoneNumber];

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? '',
      name: json['name'],
      phoneNumber: json['phoneNumber']
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phoneNumber': phoneNumber
    };
  }
}