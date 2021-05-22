import 'dart:async';

import 'package:andi_taxi/repository/gmap/geolocation_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


part 'gmap_state.dart';

class GMapCubit extends Cubit<GMapState> {

  late GoogleMapController gMapController;
  late StreamSubscription<Position> _positionSubscription;

  GMapCubit(this._geolocationRepository) : super(const GMapState()) {
    print('INTO GMapCUBIT');

    _positionSubscription = this._geolocationRepository.position.listen(
      (Position position) {
        // the state will change with the new position
        // emit the change with currentPosition 
        print(position == null ? 'Unknown' : position.latitude.toString() + ', ' + position.longitude.toString());
      }
    );
  }

  final GeolocationRepository _geolocationRepository;

  Future<void> mapCreated(GoogleMapController controller) async {
    gMapController = controller;

    try {
      var position = await _geolocationRepository.determinePosition();
      print('POSITION $position');
    } catch (e) {
      print("ON ERROR $e");
    }
    // _geolocationRepository.determinePosition()
    //   .then((value) => {
    //     print("Successfully : $value")
    //   })
    //   .catchError((error, stackTrace) {
    //     print("ON ERROR : $error");
    //   });
  }
}