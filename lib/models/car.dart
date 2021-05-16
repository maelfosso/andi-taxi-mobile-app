import 'package:equatable/equatable.dart';

class Car extends Equatable {

  const Car({
    required this.id,
    this.registrationNumber,
    this.model
  });
  
  final String id;
  final String? registrationNumber;
  final String? model;

  static const empty = Car(id: '');

  bool get isEmpty => this == Car.empty;

  bool get isNotEmpty => this != Car.empty;

  @override
  List<Object?> get props => [id, registrationNumber, model];

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      id: json['id'] ?? '',
      registrationNumber: json['registrationNumber'],
      model: json['model']
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'registrationNumber': registrationNumber,
      'model': model
    };
  }
}