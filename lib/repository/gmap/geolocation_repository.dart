import 'dart:async';

import 'package:andi_taxi/blocs/gmap/gmap_bloc.dart';
import 'package:andi_taxi/cache/cache.dart';
import 'package:andi_taxi/models/place.dart';
import 'package:andi_taxi/models/user.dart';
import 'package:andi_taxi/models/user_position.dart';
import 'package:andi_taxi/models/user_position_place.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GeolocationRepository {
  final _controller = StreamController<GMapStatus>();
  final CacheClient _cache;
  PolylinePoints polylinePoints = PolylinePoints();

  @visibleForTesting
  static const currentPositionCacheKey = '__current_position_cache_key__';

  GeolocationRepository({
    CacheClient? cache
  }): _cache = cache ?? CacheClient();

  UserPositionPlace get currentPosition {
    print('GET CURRENT POSITION');
    return _cache.read<UserPositionPlace>(key: currentPositionCacheKey) ?? UserPositionPlace.empty;
  }

  Stream<GMapStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds:  1));
    yield GMapStatus.unknown;
    yield* _controller.stream;
  }

  Stream<Position> get position {
    return Geolocator.getPositionStream();
  }

  Future<List<LatLng>> getRouteBetweenCoordinates(LatLng source, LatLng destination) async {

    List<LatLng> polylineCoordinates = [];

    try {

      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        FlutterConfig.variables['GOOGLE_MAPS_API_KEY'],
        PointLatLng(source.latitude, source.longitude),
        PointLatLng(destination.latitude, destination.longitude),
        travelMode: TravelMode.driving,
        // wayPoints: [PolylineWayPoint(location: "Sabo, Yaba Lagos Nigeria")]
      );

      print('ROUTE BETWEEKN ');
      print(result.points);
      print(result.errorMessage);
      print(result.status);

      if (result.points.isNotEmpty) {
        result.points.forEach((PointLatLng point) {
          polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        });

        
      }
    } on Exception catch (e) {
      print('EXCEPTION ON ROUTING BETWEEN COOD');
      print(e);
    }

    return polylineCoordinates;
  }

  // Future<Position> determinePosition() async {
  Future<UserPositionPlace> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    print('DETERMINE POSITION');

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the 
      // App to enable the location services.
      return Future.error(1); // ('Location services are disabled.');
    }

    print('DETERMINE POSITION - PASS ERROR 1');

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale 
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error(2); //('Location permissions are denied');
      }
    }

    print('DETERMINE POSITION - PASSED ERROR 2');
    
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately. 
      return Future.error(3);
      // (
      //   'Location permissions are permanently denied, we cannot request permissions.');
    } 

    print('DETERMINE POSITION - RETURN RESULT');
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    // var position;
    UserPositionPlace userPositionPlace = UserPositionPlace.empty;
    try {
      var position = await Geolocator.getCurrentPosition(); // (forceAndroidLocationManager: true);
      print('SUCCESS IN GET CUPORR $position');

      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude
      );
      print('PLACEMARK FROM COORDINATES : ${placemarks.length}');
      Placemark place = placemarks[0];
      
      userPositionPlace = UserPositionPlace(
        position: UserPosition.fromPosition(position),
        place: Place.fromPlacemark(place)
      );
    
      _cache.write<UserPositionPlace>(key: currentPositionCacheKey, value: userPositionPlace); // UserPosition.fromPosition(position));
      _controller.add(GMapStatus.bookingTaxi);
    } catch (e) {
      print('ERROR CALLED GET CURRENT POSITION $e');
    }


    return userPositionPlace;
  }

  double distanceBetween(UserPosition p1, UserPosition p2) {
    double distanceInMeters = Geolocator.distanceBetween(p1.latitude, p1.longitude, p2.latitude, p2.longitude);
    return distanceInMeters;
  }
}