import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'booking_taxi_event.dart';
part 'booking_taxi_state.dart';

enum BookingTaxiStatus { unknown, address, details, payment }

class BookingTaxiBloc extends Bloc<BookingTaxiEvent, BookingTaxiState> {

  BookingTaxiBloc(): super(const BookingTaxiState.unknown());

  @override
  Stream<BookingTaxiState> mapEventToState(BookingTaxiEvent event) async* {
    if (event is BookingTaxiStatusChanged) {
      yield await _mapBookingTaxiStatusChangedToState(event);
    } else if (event is BookingTaxiEnded) {
      yield await _mapBookingTaxiEndedToState(event);
    }
  }

  Future<BookingTaxiState> _mapBookingTaxiStatusChangedToState(
    BookingTaxiStatusChanged event
  ) async {
    switch (event.status) {
      default:
        return const BookingTaxiState.unknown();
    }
  }

  Future<BookingTaxiState> _mapBookingTaxiEndedToState(
    BookingTaxiEvent event
  ) async {

    return const BookingTaxiState.unknown();
  }
}