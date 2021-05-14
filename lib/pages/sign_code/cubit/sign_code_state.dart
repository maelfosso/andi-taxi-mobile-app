part of 'sign_code_cubit.dart';

class SignCodeState extends Equatable {
  static const int MAX_DURATION = 15;
  
  const SignCodeState({
    this.phoneNumber = const Phone.pure(),
    this.code = const Code.pure(),
    this.timeout = false,
    this.counter = MAX_DURATION,
    this.status = FormzStatus.pure,
  });

  final Phone phoneNumber;
  final Code code;
  final bool timeout;
  final int counter;
  final FormzStatus status;

  @override
  List<Object?> get props => [phoneNumber, code, timeout, counter, status];

  SignCodeState copyWith({
    Phone? phoneNumber,
    Code? code,
    bool? timeout,
    int? counter,
    FormzStatus? status,
  }) {
    return SignCodeState(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      code: code ?? this.code,
      timeout: timeout ?? this.timeout,
      counter: counter ?? this.counter,
      status: status ?? this.status
    );
  }
}