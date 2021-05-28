import 'dart:async';

import 'package:andi_taxi/pages/models/code.dart';
import 'package:andi_taxi/pages/models/phone.dart';
import 'package:andi_taxi/repository/authentication/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

part 'sign_code_state.dart';

class SignCodeCubit extends Cubit<SignCodeState> {
  var digits = List.filled(4, "x");
  var currentPosition = 0;
  int counter = MAX_DURATION;

  Timer? timer;
  bool _timeout = false;

  SignCodeCubit(this._authenticationRepository) : super(const SignCodeState()) {
    init();
    startTimer();
  }

  void init() async {
    emit(state.copyWith(
      phoneNumber: Phone.dirty(
        (await _authenticationRepository.currentKnowUser).phoneNumber
      )
    ));
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
            counter: 0,
            status: FormzStatus.submissionSuccess
          ));
          _timer.cancel();
        } else {
          counter--;
          emit(state.copyWith(
            counter: counter,
            status: FormzStatus.submissionSuccess
          ));
        }
      },
    );
  }

  void digitRemoved() {
    print('currentPosition $currentPosition');
    if (currentPosition > 0) {
      currentPosition -= 1;
      digits[currentPosition] = "x";

      codeChanged(digits);
    }
    print(state);
  }

  void digitAppend(int index) {
    print('digitAppend ${index}');
    print('currentPosition $currentPosition');
    if (currentPosition < 4) {
      digits[currentPosition] = "${(index == 10) ? 0 : index + 1}";
      currentPosition += 1;

      codeChanged(digits);
    }
    print(state);
  }

  void codeChanged(List<String> value) {
    print('codeChanged $value');
    final code = Code.dirty(value.join());
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
        code: state.code.value // .join(""),
      );
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on Exception {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }

  Future<void> signIn() async {
    print('signIn');
    if (!state.status.isValidated) return;
    currentPosition = 0;
    digits = List.filled(4, "x");
    emit(state.copyWith(
      code: Code.dirty(digits.join()), 
      status: FormzStatus.submissionInProgress
    ));
    try {
      await _authenticationRepository.signIn(
        phoneNumber: state.phoneNumber.value,
      );
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on Exception {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}