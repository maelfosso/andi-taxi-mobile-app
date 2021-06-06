
import 'dart:async';

import 'package:andi_taxi/blocs/booking_taxi/booking_taxi_bloc.dart';
import 'package:andi_taxi/models/models.dart';
import 'package:andi_taxi/models/user_position.dart';
import 'package:andi_taxi/models/user_position_place.dart';
import 'package:andi_taxi/pages/gmap/view/gmap_page.dart';
import 'package:andi_taxi/pages/gmap_booking/gmap_booking_view.dart';
import 'package:andi_taxi/repository/booking_taxi/booking_taxi_repository.dart';
import 'package:andi_taxi/repository/gmap/geolocation_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

part 'gmap_state.dart';
part 'gmap_event.dart';

enum GMapStatus { unknown, home, bookingTaxi, searchingTaxi, gotTaxi }

class GMapBloc extends Bloc<GMapEvent, GMapState> {

  GMapBloc({
    required GeolocationRepository geolocationRepository,
    required BookingTaxiBloc bookingTaxiBloc
  }):  _geolocationRepository = geolocationRepository, 
      super(const GMapState.unknown()) {
    _bookingTaxiBloc = bookingTaxiBloc;  // BookingTaxiBloc(geolocationRepository: geolocationRepository, bookingTaxiRepository: this._bookingTaxiRepository);
    
    _bookingTaxiBloc.stream.listen((state) {
      print('[GMAP BLOC] - Booking Taxi Bloc STream - $state');
      if (state.status == BookingTaxiStatus.ended) {
        print('[GMAP BLOC] BOOKING STATUS IS ENDED');
        add(GMapStatusChanged(GMapStatus.searchingTaxi));
      } else if (state.status == BookingTaxiStatus.canceled) {
        add(GMapStatusChanged(GMapStatus.home, message: "Booking Taxi Canceled"));
      }
    });

    _gmapStatusSubscription = _geolocationRepository.status.listen(
      (status) => add(GMapStatusChanged(status)),
    );
  }

  late BookingTaxiBloc _bookingTaxiBloc;

  final GeolocationRepository _geolocationRepository;
  final BookingTaxiRepository _bookingTaxiRepository = BookingTaxiRepository();
  late StreamSubscription<GMapStatus> _gmapStatusSubscription;
  late StreamSubscription<GMapStatus> _bookingTaxiStatusSubscription;

  @override
  Stream<GMapState> mapEventToState(GMapEvent event) async* {
    
    if (event is GMapStatusChanged) {
      yield await _mapGMapStatusChangedToState(event);
    } 
    // else if (event is GMapTapped) {
    //   yield await _mapGMapTappedToState(event);
    // }
    // else if (event is GMapBookingTaxi) {

    // }
  }

  Future<GMapState> _mapGMapStatusChangedToState(GMapStatusChanged event) async {
    switch (event.status) {      
      case GMapStatus.home:
        final position = _geolocationRepository.currentPosition;
        List<Car> cars = await _bookingTaxiRepository.taxiAround(position.position);
        print('GMAP STATUS ... HOME ... CAR GETTING');
        print(cars);

        return GMapState.home(position, event.message);

      case GMapStatus.bookingTaxi:
        final position = _geolocationRepository.currentPosition;
        // _bookingTaxiBloc.emit(BookingTaxiState.address(position, positions))
        _bookingTaxiBloc.add(BookingTaxiStatusChanged(BookingTaxiStatus.address));

        return GMapState.bookingTaxi(position);

      case GMapStatus.gotTaxi:
        return const GMapState.gotTaxi();
      
      case GMapStatus.searchingTaxi:
        return const GMapState.searchingTaxi();

      default:
        return const GMapState.unknown();
    }
  }

  // Future<GMapState> _mapGMapTappedToState(GMapTapped event) async {
  //   if (currentState) {

  //   }
  //   return;
  // }
}