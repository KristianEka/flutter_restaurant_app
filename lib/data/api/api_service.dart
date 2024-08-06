import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:restaurant_app/data/model/restaurant_detail.dart';
import 'package:restaurant_app/data/model/restaurant_list.dart';
import 'package:restaurant_app/data/model/restaurant_search.dart';

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

  Future<RestaurantDetailResult> getDetailRestaurant(
      String restaurantId) async {
    final response =
        await http.get(Uri.parse("${_baseUrl}detail/$restaurantId"));

    if (response.statusCode == 200) {
      return RestaurantDetailResult.fromJson(json.decode(response.body));
    } else {
      throw Exception(
          'Failed to load restaurant detail with Id: $restaurantId');
    }
  }

  Future<RestaurantSearchResult> searchRestaurant(String query) async {
    final response = await http.get(Uri.parse("${_baseUrl}search?q=$query"));

    if (response.statusCode == 200) {
      return RestaurantSearchResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to search restaurant $query');
    }
  }
}
