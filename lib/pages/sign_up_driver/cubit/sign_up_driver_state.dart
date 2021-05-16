part of 'sign_up_driver_cubit.dart';

class SignUpDriverState extends Equatable {
  const SignUpDriverState({
    this.name = const Name.pure(),
    this.phone = const Phone.pure(),
    this.status = FormzStatus.pure,
  });

  final Name name;
  final Phone phone;
  final FormzStatus status;

  @override
  List<Object> get props => [name, phone, status];

  SignUpDriverState copyWith({
    Name? name,
    Phone? phone,
    FormzStatus? status,
  }) {
    return SignUpDriverState(
      name: name ?? this.name,
      phone: phone ?? this.phone,
      status: status ?? this.status,
    );
  }
}
