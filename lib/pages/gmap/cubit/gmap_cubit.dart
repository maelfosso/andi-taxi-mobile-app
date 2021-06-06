import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:andi_taxi/blocs/gmap/gmap_bloc.dart';
import 'package:andi_taxi/models/place.dart';
import 'package:andi_taxi/repository/gmap/geolocation_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


part 'gmap_state.dart';

class GMapCubit extends Cubit<GMapState> {

  late GoogleMapController gMapController;
  late StreamSubscription<Position> _positionSubscription;

  late BitmapDescriptor currentLocationIcon;
  late BitmapDescriptor destinationLocationIcon;
  
  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    var bytesData = await fi.image.toByteData(format: ui.ImageByteFormat.png);
    return bytesData!.buffer.asUint8List();
   }

  GMapCubit(this._geolocationRepository) : super(GMapState(markers: {})) {
    print('INTO GMapCUBIT');


    BitmapDescriptor.fromAssetImage(
         ImageConfiguration(devicePixelRatio: 16.0),
         'assets/images/ic_setloc.png').then((onValue) {
            currentLocationIcon = onValue;
         });

    
    BitmapDescriptor.fromAssetImage(
      ImageConfiguration(
        devicePixelRatio: 0.0
      ),
      'assets/images/ic_dropoff.png').then((onValue) {
        destinationLocationIcon = onValue;
      }
    );
    // _positionSubscription = this._geolocationRepository.position.listen(
    //   (Position position) {
    //     // the state will change with the new position
    //     // emit the change with currentPosition 
    //     print(position == null ? 'Unknown' : position.latitude.toString() + ', ' + position.longitude.toString());
    //   }
    // );
  }

  final GeolocationRepository _geolocationRepository;

  PolylinePoints polylinePoints = PolylinePoints();

  
  addMarker(LatLng latLng, { String type = "destination"}) async {
    print('INTO ADD MARKER');
    var markers = new Map<MarkerId, Marker>.from(state.markers);

    if (type == "destination") {
      print('TYPE MARKER ADDED : DESTINATION : ${state.markers.length}');
      final Uint8List markerIcon = await getBytesFromAsset('assets/images/ic_dropoff.png', 100);
      markers[GMapState.destinationLocationId] = Marker(
        markerId: GMapState.destinationLocationId,
        position: latLng,
        icon: BitmapDescriptor.fromBytes(markerIcon)
      );
      print('AFTER DESTINATION : ${state.markers.length} - ${markers.length}');

      LatLng source = markers[GMapState.currentLocationId]!.position;
      LatLng destination = markers[GMapState.destinationLocationId]!.position;

      List<LatLng> polylineCoordinates = await _geolocationRepository.getRouteBetweenCoordinates(
        source, 
        destination
      );
      print('POLYLINES LIST COORDINATES');
      print(polylineCoordinates);

      if (polylineCoordinates.length > 0) {
        print('POLYLINE COOORD');
        print(polylineCoordinates);

        PolylineId id = PolylineId("travel");
        Polyline polyline = Polyline(
            polylineId: id, 
            color: Colors.red, 
            points: polylineCoordinates
        );
        state.polylines[id] = polyline;
      }
      // state.currentPosition = latLng;

      emit(
        state.copyWith(
          // currentPosition: latLng
          markers: markers
        )
      ); // .copyWith(markers: state.markers));
    }
  }

  

  Future<void> mapCreated(GoogleMapController controller) async {
    gMapController = controller;
    
    final Uint8List markerIcon = await getBytesFromAsset('assets/images/ic_setloc.png', 100);

    try {
      var position = await _geolocationRepository.determinePosition();

      var latLng = LatLng(position.position.latitude, position.position.longitude);
      var marker = Marker(
        markerId: GMapState.currentLocationId,
        position: latLng,
        icon: BitmapDescriptor.fromBytes(markerIcon)
      );

      CameraUpdate update = CameraUpdate.newLatLngZoom(latLng, 16);

      gMapController.moveCamera(update);      

      state.markers[GMapState.currentLocationId] = marker;
      emit(
        state.copyWith(
          currentPosition: latLng,
          currentPlace: position.place // Place.fromPlacemark(place)
        )
      );
      
    } catch (e) {
      print("ON ERROR $e");
      if (e == 1) {

      }
    }
  }

  void bookATaxi() {
    
  }
}