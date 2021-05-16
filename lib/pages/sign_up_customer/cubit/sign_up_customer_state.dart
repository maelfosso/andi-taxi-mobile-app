part of 'sign_up_customer_cubit.dart';


class SignUpCustomerState extends Equatable {
  const SignUpCustomerState({
    this.name = const Name.pure(),
    this.phone = const Phone.pure(),
    this.status = FormzStatus.pure,
  });

  final Name name;
  final Phone phone;
  final FormzStatus status;

  @override
  List<Object> get props => [name, phone, status];

  SignUpCustomerState copyWith({
    Name? name,
    Phone? phone,
    FormzStatus? status,
  }) {
    return SignUpCustomerState(
      name: name ?? this.name,
      phone: phone ?? this.phone,
      status: status ?? this.status,
    );
  }
}
