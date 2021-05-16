import 'package:andi_taxi/models/models.dart';
import 'package:equatable/equatable.dart';

class Driver extends Equatable {

  const Driver({
    required this.id,
    this.rcIdentificationNumber,
    this.residenceAddress,
    this.realResidenceAddress,
    this.car,
    required this.user
  });
  
  final String id;
  final String? rcIdentificationNumber;
  final String? residenceAddress;
  final String? realResidenceAddress;
  final Car? car;
  final String user;

  static const empty = Driver(id: '', user: '');

  bool get isEmpty => this == Driver.empty;

  bool get isNotEmpty => this != Driver.empty;

  @override
  List<Object?> get props => [id, rcIdentificationNumber, residenceAddress, car, user];

  factory Driver.fromJson(Map<String, dynamic> json) {
    return Driver(
      id: json['id'] ?? '',
      rcIdentificationNumber: json['rcIdentificationNumber'],
      residenceAddress: json['residenceAddress'],
      realResidenceAddress: json['realResidenceAddress'],
      car: Car.fromJson(json['car']),
      user: json['user']
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'rcIdentificationNumber': rcIdentificationNumber,
      'residenceAddress': residenceAddress,
      'realResidenceAddress': realResidenceAddress,
      'car': car?.toJson(),
      'user': user
    };
  }
}