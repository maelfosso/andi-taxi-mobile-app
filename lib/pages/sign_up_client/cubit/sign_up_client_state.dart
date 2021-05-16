part of 'sign_up_client_cubit.dart';

class SignUpClientState extends Equatable {
  const SignUpClientState({
    this.name = const Name.pure(),
    this.phone = const Phone.pure(),
    this.status = FormzStatus.pure,
  });

  final Name name;
  final Phone phone;
  final FormzStatus status;

  @override
  List<Object> get props => [name, phone, status];

  SignUpClientState copyWith({
    Name? name,
    Phone? phone,
    FormzStatus? status,
  }) {
    return SignUpClientState(
      name: name ?? this.name,
      phone: phone ?? this.phone,
      status: status ?? this.status,
    );
  }
}
