import 'dart:async';

import 'package:andi_taxi/blocs/gmap/gmap_bloc.dart';
import 'package:andi_taxi/cache/cache.dart';
import 'package:andi_taxi/models/user_position.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';

class GeolocationRepository {
  final _controller = StreamController<GMapStatus>();
  final CacheClient _cache;

  @visibleForTesting
  static const currentPositionCacheKey = '__current_position_cache_key__';

  GeolocationRepository({
    CacheClient? cache
  }): _cache = cache ?? CacheClient();

  UserPosition get currentPosition {
    return _cache.read<UserPosition>(key: currentPositionCacheKey) ?? UserPosition.empty;
  }

  Stream<GMapStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds:  1));
    yield GMapStatus.unknown;
    yield* _controller.stream;
  }

  Stream<Position> get position {
    return Geolocator.getPositionStream();
    // .listen(
    // (Position position) {
    //     print(position == null ? 'Unknown' : position.latitude.toString() + ', ' + position.longitude.toString());
    // });

  }

  Future<Position> determinePosition() async {
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
    var position;
    try {
      position = await Geolocator.getCurrentPosition(); // (forceAndroidLocationManager: true);
      print('SUCCESS IN GET CUPORR $position');
    
      _cache.write<UserPosition>(key: currentPositionCacheKey, value: UserPosition.fromPosition(position));
      _controller.add(GMapStatus.home);
    } catch (e) {
      print('ERROR CALLED GET CURRENT POSITION $e');
    }


    return position;
  }

}