import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:restaurant_app/data/model/restaurant_list.dart';

class ApiService {
  static const _baseUrl = 'https://restaurant-api.dicoding.dev/';

  Future<RestaurantListResult> getListOfRestaurant() async {
    final response = await http.get(Uri.parse("${_baseUrl}list"));

    if (response.statusCode == 200) {
      return RestaurantListResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load restaurant list');
    }
  }
}
