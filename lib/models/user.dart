import 'package:andi_taxi/models/models.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable {

  const User({
    required this.id,
    this.name,
    this.phone
  });
  
  final String id;
  final String? name;
  final String? phone;

  static const empty = User(id: '');

  bool get isEmpty => this == User.empty;

  bool get isNotEmpty => this != User.empty;

  @override
  List<Object?> get props => [id, name, phone];

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? '',
      name: json['name'],
      phone: json['phone']
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone': phone
    };
  }
}