import 'package:andi_taxi/api/api.dart';
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
      positions = await _api.GetLastLocations();
    } on Exception catch (e) {
      print('API GetLastLocations error');
      print(e);
      
      throw BookingTaxiFailure();
    }

    return positions;
  }
}