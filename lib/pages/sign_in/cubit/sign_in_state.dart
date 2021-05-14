part of 'sign_in_cubit.dart';

class SignInState extends Equatable {
  const SignInState({
    this.phone = const Phone.pure(),
    this.status = FormzStatus.pure,
  });

  final Phone phone;
  final FormzStatus status;

  @override
  List<Object?> get props => [phone, status];

  SignInState copyWith({
    Phone? phone,
    FormzStatus? status,
  }) {
    return SignInState(
      phone: phone ?? this.phone,
      status: status ?? this.status
    );
  }
}