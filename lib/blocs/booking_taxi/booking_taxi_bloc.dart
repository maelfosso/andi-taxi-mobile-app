import 'package:andi_taxi/models/user_position_place.dart';
import 'package:andi_taxi/repository/gmap/geolocation_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'booking_taxi_event.dart';
part 'booking_taxi_state.dart';

enum BookingTaxiStatus { unknown, address, details, payment }

class BookingTaxiBloc extends Bloc<BookingTaxiEvent, BookingTaxiState> {

  BookingTaxiBloc({
    required GeolocationRepository geolocationRepository
  }): _geolocationRepository = geolocationRepository,
      super(const BookingTaxiState.unknown()) {
    
    // var position = _geolocationRepository.determinePosition();
    add(BookingTaxiStatusChanged(BookingTaxiStatus.address));
  }

  final GeolocationRepository _geolocationRepository;

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
      case BookingTaxiStatus.address:
        final position = _geolocationRepository.currentPosition;

        return BookingTaxiState.address(position);
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