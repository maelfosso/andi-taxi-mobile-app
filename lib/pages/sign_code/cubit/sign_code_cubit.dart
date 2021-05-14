import 'dart:async';

import 'package:andi_taxi/pages/models/code.dart';
import 'package:andi_taxi/pages/models/phone.dart';
import 'package:andi_taxi/repository/authentication/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

part 'sign_code_state.dart';

class SignCodeCubit extends Cubit<SignCodeState> {
  var digits = List.filled(4, "");
  var currentPosition = 0;
  int counter = 0;

  Timer? timer;
  bool _timeout = false;

  SignCodeCubit(this._authenticationRepository) : super(const SignCodeState()) {
    startTimer();
  }

  final AuthenticationRepository _authenticationRepository;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);

    timer = new Timer.periodic(
      oneSec,
      (Timer _timer) {
        if (counter == 0) {
          emit(state.copyWith(
            timeout: true,
            counter: 0
          ));
          _timer.cancel();
          // setState(() {
          //   timer.cancel();
          //   _timeout = true;
          // });
        } else {
          counter--;
          emit(state.copyWith(
            counter: counter
          ));
          // setState(() {
          //   _counter--;
          // });
        }
      },
    );
  }

  void digitRemoved() {
    if (currentPosition > 0) {
      currentPosition -= 1;
      digits[currentPosition] = "";

      codeChanged(digits.join(""));
    }
  }

  void digitAppend(int index) {
    if (currentPosition < 4) {
      digits[currentPosition] = "${(index == 10) ? 0 : index + 1}";
      currentPosition += 1;

      codeChanged(digits.join(""));
    }
  }

  void codeChanged(String value) {
    final code = Code.dirty(value);
    emit(state.copyWith(
      code: code,
      status: Formz.validate([code])
    ));
  }

  Future<void> signCode() async {
    print("submit the code");
    if (!state.status.isValidated) return;
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await _authenticationRepository.signCode(
        phoneNumber: state.phoneNumber.value,
        code: state.code.value,
      );
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on Exception {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}