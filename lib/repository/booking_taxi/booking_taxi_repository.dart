import 'package:andi_taxi/api/api.dart';
import 'package:andi_taxi/models/models.dart';
import 'package:andi_taxi/models/user_position.dart';

class BookingTaxiFailure implements Exception {}

class BookingTaxiRepository {

  BookingTaxiRepository({
    RestClient? api
  }) : _api = api ?? APIs.getRestClient();

  final RestClient _api;

  Future<List<UserPosition>> lastLocations() async {
    print('GET LAST LOCATIONS...');
    List<UserPosition> positions = [];

    try {
      print('BEFORE GETTING API');
      positions = await _api.GetLastLocations();
      print('AFTER GETTING : $positions');
    } on Exception catch (e) {
      print('API GetLastLocations error');
      print(e);
      
      throw BookingTaxiFailure();
    }

    print('RETURN RESULTS ... $positions');

    return positions;
  }

  Future<List<Car>> taxiAround(UserPosition position) async {
    print("GET TAXI AROUND");
    List<Car> cars = [];
    
    try {
      print('BEFORE GETING API : $position');
      cars = await _api.GetTaxiAround(position);
      print('AFTER GETTINGS : $cars');
    } on Exception catch (e) {
      print('API GET TAXI ARROUND error');
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
    print("CALCULATE COST TIME");
    List<double> results = [];
    
    try {
      print('CALCULATE : $from --- $to --- $distance');
      results = await _api.CalculateCostTime(from, to, distance);
      print('AFTER GETTINGS : $results');
    } on Exception catch (e) {
      print('API CALCULATE error');
      print(e);

      throw BookingTaxiFailure();
    }

    return results;
  }
}