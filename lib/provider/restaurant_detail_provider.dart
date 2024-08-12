import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant_detail.dart';
import 'package:restaurant_app/utils/result_state.dart';

class RestaurantDetailProvider extends ChangeNotifier {
  final ApiService apiService;
  late String restaurantId;

  RestaurantDetailProvider({required this.apiService});

  late RestaurantDetailResult _restaurantDetailResult;
  late ResultState _state = ResultState.loading;
  String _message = '';

  String get message => _message;

  RestaurantDetailResult get result => _restaurantDetailResult;

  ResultState get state => _state;

  Future<dynamic> fetchRestaurantDetail(String restaurantId) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurantDetail =
          await apiService.getDetailRestaurant(restaurantId);
      if (restaurantDetail.restaurant.id.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = restaurantDetail.message;
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantDetailResult = restaurantDetail;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      if (e is SocketException) {
        return _message = 'No internet connection';
      } else {
        return _message = 'Error --> $e';
      }
    }
  }

  late final String _restaurantIdSelected;

  String get restaurantIdSelected => _restaurantIdSelected;

  void saveRestaurantIdSelected(String restaurantId) {
    _restaurantIdSelected = restaurantId;
    notifyListeners();
  }
}
