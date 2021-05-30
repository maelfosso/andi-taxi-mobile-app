import 'dart:async';

import 'package:andi_taxi/api/api.dart';
import 'package:andi_taxi/blocs/gmap/gmap_bloc.dart';
import 'package:andi_taxi/models/models.dart';
import 'package:andi_taxi/models/payment-methods-used.dart';
import 'package:andi_taxi/models/user_position.dart';

class BookingTaxiFailure implements Exception {}

class BookingTaxiRepository {
  final _controller = StreamController<GMapStatus>();

  BookingTaxiRepository({
    RestClient? api
  }) : _api = api ?? APIs.getRestClient();

  final RestClient _api;

  Stream<GMapStatus> get status async* {
    // await Future<void>.delayed(const Duration(seconds: 1));
    // yield GMapStatus.unknown; // instead of unauthenticated
    yield* _controller.stream;
  }

  Future<List<UserPosition>> lastLocations() async {
    List<UserPosition> positions = [];

    try {
      positions = await _api.GetLastLocations();
    } on Exception catch (e) {
      throw BookingTaxiFailure();
    }

    return positions;
  }

  Future<List<Car>> taxiAround(UserPosition position) async {
    List<Car> cars = [];
    
    try {
      cars = await _api.GetTaxiAround(position);
    } on Exception catch (e) {
      print('TAXI ARROUND ERROR ');
      print(e);
      throw BookingTaxiFailure();
    }

    return cars;
  }

  Future<List<double>> calculateCostTime(
    UserPosition from,
    UserPosition to,
    double distance
  ) async {
    List<double> results = [];
    
    try {
      results = await _api.CalculateCostTime(from, to, distance);
    } on Exception catch (e) {
      print('CACULATE COST TIME ');
      print(e);
      throw BookingTaxiFailure();
    }

    return results;
  }

  Future<List<PaymentMethodUsed>> paymentMethodsUsed() async {
    List<PaymentMethodUsed> methods = [];

    try {
      methods = await _api.GetPaymentMethodsUsed();
    } on Exception catch (e) {
      throw BookingTaxiFailure();
    }

    return methods;
  }

  void payTravel(String travelId, PaymentMethodUsed method) async {
    print('PAYTRAVEL AFTER ... ');
    try {
      _controller.add(GMapStatus.searchingTaxi);
    } on Exception catch (e) {
      throw BookingTaxiFailure();
    }
  }
}