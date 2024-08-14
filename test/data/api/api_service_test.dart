import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:mockito/annotations.dart';
import 'package:restaurant_app/data/model/restaurant_list.dart';

const _baseUrl = 'https://restaurant-api.dicoding.dev/';

Future<RestaurantListResult> getListOfRestaurant(http.Client client) async {
  final response = await client.get(Uri.parse("${_baseUrl}list"));

  if (response.statusCode == 200) {
    return RestaurantListResult.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load restaurant list');
  }
}

@GenerateMocks([http.Client])
void main() {
  group('ApiService', () {
    test(
        'returns a RestaurantListResult if the http call completes successfully',
        () async {
      // Mock response data
      final mockResponse = {
        "error": false,
        "message": "success",
        "count": 1,
        "restaurants": [
          {
            "id": "rqdv5juczeskfw1e867",
            "name": "Melting Pot",
            "description": "Lorem ipsum dolor sit amet.",
            "pictureId": "14",
            "city": "Medan",
            "rating": 4.2
          }
        ]
      };

      // Setup the mock client
      final client = MockClient(
        (_) async => http.Response(jsonEncode(mockResponse), 200),
      );

      // Call the function and check the result
      expect(await getListOfRestaurant(client), isA<RestaurantListResult>());

      final result = await getListOfRestaurant(client);

      // Validate the response fields
      expect(result.error, false);
      expect(result.message, "success");
      expect(result.count, 1);
      expect(result.restaurants.length, 1);
      expect(result.restaurants[0].name, "Melting Pot");
    });

    test('throws an exception if the http call completes with an error',
        () async {
      final client = MockClient(
        (_) async => http.Response('Not Found', 404),
      );

      // Call the function and check for an exception
      expect(() async => await getListOfRestaurant(client), throwsException);
    });
  });
}
