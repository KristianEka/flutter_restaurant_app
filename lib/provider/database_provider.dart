import 'package:flutter/foundation.dart';
import 'package:restaurant_app/data/db/database_helper.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/utils/result_state.dart';

class DatabaseProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;

  DatabaseProvider({required this.databaseHelper}) {
    _getFavorites();
  }

  late ResultState _state;
  String _message = '';
  List<Restaurant> _favorites = [];

  ResultState get state => _state;

  String get message => _message;

  List<Restaurant> get favorites => _favorites;

  void _getFavorites() async {
    _favorites = await databaseHelper.getFavorites();
    if (_favorites.isNotEmpty) {
      _state = ResultState.hasData;
    } else {
      _state = ResultState.noData;
      _message = 'Empty Data';
    }
    notifyListeners();
  }

  void addFavorite(Restaurant restaurant) async {
    try {
      await databaseHelper.insertFavorite(restaurant);
      _getFavorites();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Error -> $e';
      notifyListeners();
    }
  }

  Future<bool> isFavorite(String restaurantId) async {
    final favoriteRestaurant =
        await databaseHelper.getFavoriteById(restaurantId);
    return favoriteRestaurant.isNotEmpty;
  }

  void removeFavorite(String restaurantId) async {
    try {
      await databaseHelper.removeFavorite(restaurantId);
      _getFavorites();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Error -> $e';
      notifyListeners();
    }
  }
}
