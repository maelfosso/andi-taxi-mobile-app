
import 'dart:async';

import 'package:andi_taxi/models/models.dart';
import 'package:andi_taxi/models/user_position.dart';
import 'package:andi_taxi/models/user_position_place.dart';
import 'package:andi_taxi/pages/gmap/view/gmap_page.dart';
import 'package:andi_taxi/repository/booking_taxi/booking_taxi_repository.dart';
import 'package:andi_taxi/repository/gmap/geolocation_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

part 'gmap_state.dart';
part 'gmap_event.dart';

enum GMapStatus { unknown, home, bookingTaxi, searchingTaxi, gotTaxi }

class GMapBloc extends Bloc<GMapEvent, GMapState> {

  GMapBloc({
    required GeolocationRepository geolocationRepository,
  }):  _geolocationRepository = geolocationRepository, 
      super(const GMapState.unknown()) {
    _gmapStatusSubscription = _geolocationRepository.status.listen(
      (status) => add(GMapStatusChanged(status)),
    );
  }

  final GeolocationRepository _geolocationRepository;
  final BookingTaxiRepository _bookingTaxiRepository = BookingTaxiRepository();
  late StreamSubscription<GMapStatus> _gmapStatusSubscription;

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

        return GMapState.home(position);

      case GMapStatus.bookingTaxi:
        final position = _geolocationRepository.currentPosition;

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