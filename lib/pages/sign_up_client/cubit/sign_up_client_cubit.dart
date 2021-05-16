import 'package:andi_taxi/pages/models/name.dart';
import 'package:andi_taxi/pages/models/phone.dart';
import 'package:andi_taxi/repository/authentication/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

part 'sign_up_client_state.dart';

class SignUpClientCubit extends Cubit<SignUpClientState> {
  SignUpClientCubit(this._authenticationRepository) : super(const SignUpClientState());

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
    print('SignUpClientSubmitted : ${state.name.value} - ${state.phone.value}');
    print('SignUpClientFormStatus : ${state.status.isValid}');
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await _authenticationRepository.signUpClient(
        name: state.name.value,
        phone: state.phone.value,
      );
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on Exception catch (e) {
      print('SignUpClientFormSubmitted : throw exception \n $e');
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}
