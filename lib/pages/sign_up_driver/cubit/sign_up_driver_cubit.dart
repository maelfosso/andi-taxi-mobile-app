import 'package:andi_taxi/models/car.dart';
import 'package:andi_taxi/pages/models/name.dart';
import 'package:andi_taxi/pages/models/phone.dart';
import 'package:andi_taxi/repository/authentication/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

part 'sign_up_driver_state.dart';

class SignUpDriverCubit extends Cubit<SignUpDriverState> {
  SignUpDriverCubit(this._authenticationRepository) : super(const SignUpDriverState());

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
  
  void rcIdentificationNumberChanged(String value) {
    final rcIdentificationNumber = Name.dirty(value);
    emit(state.copyWith(
      rcIdentificationNumber: rcIdentificationNumber,
      status: Formz.validate([
        rcIdentificationNumber,
        state.phone,
      ]),
    ));
  }

  void residenceAddressChanged(String value) {
    final residenceAddress = Name.dirty(value);
    emit(state.copyWith(
      residenceAddress: residenceAddress,
      status: Formz.validate([
        residenceAddress,
        state.phone,
      ]),
    ));
  }

  void realResidenceAddressChanged(String value) {
    final realResidenceAddress = Name.dirty(value);
    emit(state.copyWith(
      realResidenceAddress: realResidenceAddress,
      status: Formz.validate([
        realResidenceAddress,
        state.phone,
      ]),
    ));
  }

  void carRegistrationNumberChanged(String value) {
    final carRegistrationNumber = Name.dirty(value);
    emit(state.copyWith(
      carRegistrationNumber: carRegistrationNumber,
      status: Formz.validate([
        carRegistrationNumber,
        state.phone,
      ]),
    ));
  }

  void carModelChanged(String value) {
    final carModel = Name.dirty(value);
    emit(state.copyWith(
      carModel: carModel,
      status: Formz.validate([
        carModel,
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
    print('SignUpDriverSubmitted : ${state.name.value} - ${state.phone.value}');
    print('SignUpDriverFormStatus : ${state.status.isValid}');
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await _authenticationRepository.signUpDriver(
        name: state.name.value,
        phone: state.phone.value,
        rcIdentificationNumber: state.rcIdentificationNumber.value,
        residenceAddress: state.residenceAddress.value,
        realResidenceAddress: state.realResidenceAddress.value,
        car: Car(id: '', registrationNumber: state.realResidenceAddress.value, model: state.carModel.value)
      );
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on Exception catch (e) {
      print('SignUpDriverFormSubmitted : throw exception \n $e');
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}
