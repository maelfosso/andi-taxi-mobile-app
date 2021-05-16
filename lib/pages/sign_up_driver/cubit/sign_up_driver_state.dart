part of 'sign_up_driver_cubit.dart';

class SignUpDriverState extends Equatable {
  const SignUpDriverState({
    this.name = const Name.pure(),
    this.phone = const Phone.pure(),
    this.rcIdentificationNumber = const Name.pure(),
    this.residenceAddress = const Name.pure(),
    this.realResidenceAddress = const Name.pure(),
    this.carRegistrationNumber = const Name.pure(),
    this.carModel = const Name.pure(),
    this.status = FormzStatus.pure,
  });

  final Name name;
  final Phone phone;
  final Name rcIdentificationNumber;
  final Name residenceAddress;
  final Name realResidenceAddress;
  final Name carRegistrationNumber;
  final Name carModel;
  final FormzStatus status;

  @override
  List<Object> get props => [
    name, phone, 
    rcIdentificationNumber, residenceAddress, realResidenceAddress, 
    carRegistrationNumber, carModel, 
    status
  ];

  SignUpDriverState copyWith({
    Name? name,
    Phone? phone,
    Name? rcIdentificationNumber,
    Name? residenceAddress,
    Name? realResidenceAddress,
    Name? carRegistrationNumber,
    Name? carModel,
    FormzStatus? status,
  }) {
    return SignUpDriverState(
      name: name ?? this.name,
      phone: phone ?? this.phone,
      rcIdentificationNumber: rcIdentificationNumber ?? this.rcIdentificationNumber,
      residenceAddress: residenceAddress ?? this.residenceAddress,
      realResidenceAddress: realResidenceAddress ?? this.realResidenceAddress,
      carRegistrationNumber: carRegistrationNumber ?? this.carRegistrationNumber,
      carModel: carModel ?? this.carModel,
      status: status ?? this.status,
    );
  }
}
