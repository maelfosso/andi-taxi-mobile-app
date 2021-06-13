import 'dart:convert';
import 'dart:io';

import 'package:andi_taxi/models/user_position_place.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:http/http.dart';

class PlaceApiProvider {
  final client = Client();

  PlaceApiProvider(this.sessionToken);

  final sessionToken;

  // static final String androidKey = 'YOUR_API_KEY_HERE';
  // static final String iosKey = 'YOUR_API_KEY_HERE';
  final apiKey = FlutterConfig.variables['GOOGLE_MAPS_API_KEY']; // Platform.isAndroid ? androidKey : iosKey;

  Future<List<Suggestion>> fetchSuggestions(String input, String lang) async {
    print('FETCH SUGGESTIONS INIT....');
    final request =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&types=address&language=$lang&components=country:ch&key=$apiKey&sessiontoken=$sessionToken';
    final response = await client.get(Uri.parse(request));
    print(response);
    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      print(result);
      if (result['status'] == 'OK') {
        // compose suggestions in a list
        return result['predictions']
            .map<Suggestion>((p) => Suggestion(p['place_id'], p['description']))
            .toList();
      }
      if (result['status'] == 'ZERO_RESULTS') {
        return [];
      }
      throw Exception(result['error_message']);
    } else {
      print('FAILED TO FETCH SUGGESTION');
      throw Exception('Failed to fetch suggestion');
    }
  }

  Future<UserPositionPlace> getPlaceDetailFromId(String placeId) async {
    // if you want to get the details of the selected place by place_id
    final request =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&fields=address_component&key=$apiKey&sessiontoken=$sessionToken';
    final response = await client.get(Uri.parse(request));

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result['status'] == 'OK') {
        final components =
            result['result']['address_components'] as List<dynamic>;
        // build result
        final place = UserPositionPlace.empty;
        components.forEach((c) {
          final List type = c['types'];
          print('RESULT ITEM');
          print(c);
          print(type);
          print('\n');
          // if (type.contains('street_number')) {
          //   place.streetNumber = c['long_name'];
          // }
          // if (type.contains('route')) {
          //   place.street = c['long_name'];
          // }
          // if (type.contains('locality')) {
          //   place.city = c['long_name'];
          // }
          // if (type.contains('postal_code')) {
          //   place.zipCode = c['long_name'];
          // }
        });
        return place;
      }
      throw Exception(result['error_message']);
    } else {
      throw Exception('Failed to fetch suggestion');
    }

    return Future.value(null);
  }
}

class Suggestion {
  final String placeId;
  final String description;

  Suggestion(this.placeId, this.description);

  @override
  String toString() {
    return 'Suggestion(description: $description, placeId: $placeId)';
  }
}
