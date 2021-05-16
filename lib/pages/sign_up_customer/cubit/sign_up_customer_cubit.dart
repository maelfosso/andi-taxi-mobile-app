import 'package:andi_taxi/pages/models/name.dart';
import 'package:andi_taxi/pages/models/phone.dart';
import 'package:andi_taxi/repository/authentication/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

part 'sign_up_customer_state.dart';

class SignUpCustomerCubit extends Cubit<SignUpCustomerState> {
  SignUpCustomerCubit(this._authenticationRepository) : super(const SignUpCustomerState());

  final AuthenticationRepository _authenticationRepository;

  void nameChanged(String value) {
    final name = Name.dirty(value);
    emit(state.copyWith(
      name: name,
      status: Formz.validate([
        name,
        state.phone,
      ]),
    ));
  }

  void phoneChanged(String value) {
    final phone = Phone.dirty(value);
    emit(state.copyWith(
      phone: phone,
      status: Formz.validate([
        state.name,
        phone,
      ]),
    ));
  }

  Future<void> signUpFormSubmitted() async {
    print('SignUpCustomerSubmitted : ${state.name.value} - ${state.phone.value}');
    print('SignUpCustomerFormStatus : ${state.status.isValid}');
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await _authenticationRepository.signUpCustomer(
        name: state.name.value,
        phone: state.phone.value,
      );
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on Exception catch (e) {
      print('SignUpCustomerFormSubmitted : throw exception \n $e');
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}
