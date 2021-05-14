part of 'sign_up_cubit.dart';


class SignUpState extends Equatable {
  const SignUpState({
    this.name = const Name.pure(),
    this.phone = const Phone.pure(),
    this.status = FormzStatus.pure,
  });

  final Name name;
  final Phone phone;
  final FormzStatus status;

  @override
  List<Object> get props => [name, phone, status];

  SignUpState copyWith({
    Name? name,
    Phone? phone,
    FormzStatus? status,
  }) {
    return SignUpState(
      name: name ?? this.name,
      phone: phone ?? this.phone,
      status: status ?? this.status,
    );
  }
}
