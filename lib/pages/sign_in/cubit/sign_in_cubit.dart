import 'package:andi_taxi/pages/models/name.dart';
import 'package:andi_taxi/pages/models/phone.dart';
import 'package:andi_taxi/repository/authentication/authentication_repository.dart';
import 'package:andi_taxi/ui/sign_in.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/animation.dart';
import 'package:formz/formz.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit(this._authenticationRepository) : super(const SignInState());

  final AuthenticationRepository _authenticationRepository;

  // void nameChanged(String value) {
  //   final name = Name.dirty(value);
  //   emit(state.copyWith(
  //     name: name,
  //     status: Formz.validate([name, state.phone])
  //   ));
  // }

  void phoneChanged(String value) {
    final phone = Phone.dirty(value);
    emit(state.copyWith(
      phone: phone,
      status: Formz.validate([phone])
    ));
  }

  Future<void> signIn() async {
    if (!state.status.isValidated) return;
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await _authenticationRepository.signIn(
        // name: state.email.value,
        phone: state.phone.value,
      );
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on Exception {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}