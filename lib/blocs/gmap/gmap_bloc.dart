
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
      super(const GMapState.home(UserPositionPlace.empty, "")) {
    _bookingTaxiBloc = bookingTaxiBloc;
    
    _bookingTaxiBloc.stream.listen((state) {
      if (state.status == BookingTaxiStatus.ended) {
        add(GMapStatusChanged(GMapStatus.searchingTaxi));
      } else if (state.status == BookingTaxiStatus.address && state.to != UserPositionPlace.empty) {
        
      } else if (state.status == BookingTaxiStatus.canceled || state.status == BookingTaxiStatus.unknown) {
        add(GMapStatusChanged(GMapStatus.home, message: "Booking Taxi Canceled"));
      }
    });

    _gmapStatusSubscription = _geolocationRepository.status.listen(
      (status) => add(GMapStatusChanged(status)),
    );

    // add()
    print('ADD ENVENT BOOKING TAXI');
    add(GMapStatusChanged(GMapStatus.bookingTaxi));
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
  }

  Future<GMapState> _mapGMapStatusChangedToState(GMapStatusChanged event) async {
    switch (event.status) {      
      case GMapStatus.home:
        final position = _geolocationRepository.currentPosition;
        List<Car> cars = await _bookingTaxiRepository.taxiAround(position.position);
        print(cars);

        return GMapState.home(position, event.message);

      case GMapStatus.bookingTaxi:
        final position = _geolocationRepository.currentPosition;
        _bookingTaxiBloc.add(BookingTaxiStatusChanged(BookingTaxiStatus.home));

        print('INITI BOOKING TAXI EVENT STATUS CHANGED');
        print(position);

        return GMapState.bookingTaxi(position);

      case GMapStatus.gotTaxi:
        return const GMapState.gotTaxi();
      
      case GMapStatus.searchingTaxi:
        return const GMapState.searchingTaxi();

      default:
        return const GMapState.unknown();
    }
  }

}