import 'package:flutter/foundation.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant_search.dart';
import 'package:restaurant_app/provider/result_state.dart';

class RestaurantSearchProvider extends ChangeNotifier {
  final ApiService apiService;
  final String query;

  RestaurantSearchProvider({required this.apiService, required this.query}) {
    _fetchSearchRestaurant(query);
  }

  late RestaurantSearchResult _restaurantSearchResult;
  late ResultState _state;
  String _message = '';

  String get message => _message;

  RestaurantSearchResult get result => _restaurantSearchResult;

  ResultState get state => _state;

  Future<dynamic> _fetchSearchRestaurant(String query) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurant = await apiService.searchRestaurant(query);

      if (restaurant.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantSearchResult = restaurant;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
