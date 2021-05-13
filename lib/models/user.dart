import 'package:equatable/equatable.dart';

class User extends Equatable {

  const User({
    this.id,
    this.name,
    this.phone
  });
  
  final String id;
  final String name;
  final String phone;

  static const empty = User(id: '');

  bool get isEmpty => this == User.empty;

  bool get isNotEmpty => this != User.empty;

  @override
  List<Object> get props => [id, name, phone];
}