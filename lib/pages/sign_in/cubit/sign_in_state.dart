part of 'sign_in_cubit.dart';

class SignInState extends Equatable {
  const SignInState({
    // this.name = const Name.pure(),
    this.phone = const Phone.pure(),
    this.status = FormzStatus.pure,
  });

  // final Name name;
  final Phone phone;
  final FormzStatus status;

  @override
  List<Object?> get props => [phone, status];

  SignInState copyWith({
    Name? name,
    Phone? phone,
    FormzStatus? status,
  }) {
    return SignInState(
      // name: name ?? this.name,
      phone: phone ?? this.phone,
      status: status ?? this.status
    );
  }
}