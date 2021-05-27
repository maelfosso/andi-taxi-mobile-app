import 'package:andi_taxi/models/place.dart';
import 'package:andi_taxi/models/user_position.dart';
import 'package:andi_taxi/models/user_position_place.dart';
import 'package:andi_taxi/repository/gmap/geolocation_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
    } else if (event is DestinationAddressAdded) {
      yield await _mapDestinationAddressAddedToState(event);
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
        print('[MAP BOOKING STATUS CHANGED] POSITION : $position');
        return BookingTaxiState.address(position);
      default:
        return const BookingTaxiState.unknown();
    }
  }

  Future<BookingTaxiState> _mapDestinationAddressAddedToState(
    DestinationAddressAdded event
  ) async {
    final position = event.position;
    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude
    );
    Placemark place = placemarks[0];
    
    var userPositionPlace = UserPositionPlace(
      position: UserPosition.fromLatLng(position),
      place: Place.fromPlacemark(place)
    );

    return state.copyWith(to: userPositionPlace);
  }

  Future<BookingTaxiState> _mapBookingTaxiEndedToState(
    BookingTaxiEvent event
  ) async {

    return const BookingTaxiState.unknown();
  }
}