import 'package:andi_taxi/models/payment-methods-used.dart';
import 'package:andi_taxi/models/place.dart';
import 'package:andi_taxi/models/user_position.dart';
import 'package:andi_taxi/models/user_position_place.dart';
import 'package:andi_taxi/repository/booking_taxi/booking_taxi_repository.dart';
import 'package:andi_taxi/repository/gmap/geolocation_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'booking_taxi_event.dart';
part 'booking_taxi_state.dart';

enum BookingTaxiStatus { unknown, address, details, payment, ended, canceled }

enum CarType { standard, vip, scooter, access, baby, electric, exec, van }

enum PaymentMethod { cash, visa, mastercard }

class BookingTaxiBloc extends Bloc<BookingTaxiEvent, BookingTaxiState> {

  BookingTaxiBloc({
    required GeolocationRepository geolocationRepository,
    required BookingTaxiRepository bookingTaxiRepository
  }): _geolocationRepository = geolocationRepository,
      _bookingTaxiRepository = bookingTaxiRepository,
      super(const BookingTaxiState.unknown()) {
    
    // var position = _geolocationRepository.determinePosition();
    print('INIT BOOKING TAXI BLOC $state');
    // add(BookingTaxiStatusChanged(BookingTaxiStatus.address));
  }

  final GeolocationRepository _geolocationRepository;
  final BookingTaxiRepository _bookingTaxiRepository;

  @override
  Stream<BookingTaxiState> mapEventToState(BookingTaxiEvent event) async* {
    if (event is BookingTaxiStatusChanged) {
      yield await _mapBookingTaxiStatusChangedToState(event);
    } else if (event is DestinationAddressAdded) {
      yield await _mapDestinationAddressAddedToState(event);
    } else if (event is BookingAddressSetUp) {
      yield await _mapBookingAddressSetUpToState(event);
    } else if (event is BookingDetailsSetUp) {
      yield await _mapBookingDetailsSetUpToState(event);
    } else if (event is BookingPaymentSetUp) {
      yield await _mapBookingPaymentSetUpToState(event);
    } else if (event is BookingTaxiEnded) {
      yield await _mapBookingTaxiEndedToState(event);
    } else if (event is BookingTaxiPreviousStep) {
      yield await _mapBookingTaxiPreviousStepToState(event);
    }
  }

  Future<BookingTaxiState> _mapBookingTaxiStatusChangedToState(
    BookingTaxiStatusChanged event
  ) async {
    print('_mapBOKING STATUS CHANGED : ${event.status}');
    
    switch (event.status) {
      case BookingTaxiStatus.address:

        final currentPosition = _geolocationRepository.currentPosition;
        List<UserPosition> lastPositions = await _bookingTaxiRepository.lastLocations();
        // List<UserPosition> lastPositions = [];

        print('CURRENT POSITION $currentPosition');
        print('LAST POSITION $lastPositions');

        return BookingTaxiState.address(currentPosition, lastPositions);
        
      case BookingTaxiStatus.canceled:

        return BookingTaxiState.canceled();
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

  Future<BookingTaxiState> _mapBookingAddressSetUpToState(
    BookingAddressSetUp event
  ) async {
    // From Google MAP, Calculate 
    // - the distance
    // - The time of travel
    double distance = _geolocationRepository.distanceBetween(state.from.position, state.to.position);

    List<double> results = await _bookingTaxiRepository.calculateCostTime(
      state.from.position, 
      state.to.position, 
      distance
    );

    // From API, les Fetch
    // - car (last car type used)
    // - cost range 
    // - payment method (last payment method used)

    return state.copyWith(
      status: BookingTaxiStatus.details,
      cost: results.getRange(0, 2).toList(),
      time: results[2].toInt()
    );
  }

  Future<BookingTaxiState> _mapBookingDetailsSetUpToState(
    BookingTaxiEvent event
  ) async {
    // Create the Travel in a Unpaid state. Return the id of the travel
    List<PaymentMethodUsed> methods = await _bookingTaxiRepository.paymentMethodsUsed();

    return state.copyWith(
      status: BookingTaxiStatus.payment,
      paymentMethodUsed: methods,
      // travelId: travelId
    );
  }

  Future<BookingTaxiState> _mapBookingPaymentSetUpToState(
    BookingPaymentSetUp event
  ) async {
    // _geolocationRepository.status
    print('BOOKING BLOC - MAP PAYMENT SETUP TO... ${event.method}');
    _bookingTaxiRepository.payTravel("travelId", event.method);
    return const BookingTaxiState.ended();
  }

  Future<BookingTaxiState> _mapBookingTaxiEndedToState(
    BookingTaxiEvent event
  ) async {

    return const BookingTaxiState.unknown();
  }

  Future<BookingTaxiState> _mapBookingTaxiPreviousStepToState(
    BookingTaxiPreviousStep event
  ) async {
    BookingTaxiStatus status;
    if (state.status == BookingTaxiStatus.address) {
      status = BookingTaxiStatus.unknown; // canceled;
    } else if (state.status == BookingTaxiStatus.details) {
      status = BookingTaxiStatus.address;
    } else {
      status = BookingTaxiStatus.details;
    }

    return state.copyWith(
      status: status
    );
  }
}