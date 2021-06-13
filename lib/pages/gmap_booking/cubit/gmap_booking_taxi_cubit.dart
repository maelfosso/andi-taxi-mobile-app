import 'package:andi_taxi/pages/models/phone.dart';
import 'package:andi_taxi/repository/authentication/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:uuid/uuid.dart';

part 'gmap_booking_taxi_state.dart';

class GMapBookingTaxiCubit extends Cubit<GMapBookingTaxiState> {
  GMapBookingTaxiCubit(this._authenticationRepository) : super(const GMapBookingTaxiState());

  final AuthenticationRepository _authenticationRepository;

  void searchPlaces() {

  }

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
        phoneNumber: state.phone.value,
      );
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on Exception {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}