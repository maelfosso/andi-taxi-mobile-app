import 'dart:async';

import 'package:andi_taxi/blocs/gmap/gmap_bloc.dart';
import 'package:andi_taxi/models/place.dart';
import 'package:andi_taxi/repository/gmap/geolocation_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


part 'gmap_state.dart';

class GMapCubit extends Cubit<GMapState> {

  late GoogleMapController gMapController;
  late StreamSubscription<Position> _positionSubscription;

  GMapCubit(this._geolocationRepository) : super(GMapState(markers: {})) {
    print('INTO GMapCUBIT');

    // _positionSubscription = this._geolocationRepository.position.listen(
    //   (Position position) {
    //     // the state will change with the new position
    //     // emit the change with currentPosition 
    //     print(position == null ? 'Unknown' : position.latitude.toString() + ', ' + position.longitude.toString());
    //   }
    // );
  }

  final GeolocationRepository _geolocationRepository;

  Future<void> mapCreated(GoogleMapController controller) async {
    gMapController = controller;

    print('MAP CREATED ...');

    try {
      var position = await _geolocationRepository.determinePosition();
      print('POSITION $position');

      var latLng = LatLng(position.latitude, position.longitude);
      var marker = Marker(
        markerId: GMapState.currentLocationId,
        position: latLng
      );

      CameraUpdate update = CameraUpdate.newLatLngZoom(latLng, 16);

      gMapController.moveCamera(update);      

      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude
      );
      print('PLACEMARK FROM COORDINATES : ${placemarks.length}');
      Placemark place = placemarks[0];
      print("FIRST PALCEMARK : ${place.locality}, ${place.postalCode}, ${place.country}");

      state.markers[GMapState.currentLocationId] = marker;
      // state.currentPlacemark = place;
      emit(
        state.copyWith(
          currentPosition: latLng,
          // markers: state.markers,
          currentPlace: Place.fromPlacemark(place)
        )
      );
      
    } catch (e) {
      print("ON ERROR $e");
      if (e == 1) {

      }
    }
  }
}