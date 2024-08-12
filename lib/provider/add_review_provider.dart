import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/review.dart';
import 'package:restaurant_app/utils/result_state.dart';

class AddReviewProvider extends ChangeNotifier {
  final ApiService apiService;

  AddReviewProvider({required this.apiService});

  late AddReviewResult _addReviewResult;
  late ResultState _state;
  String _message = '';

  String get message => _message;

  AddReviewResult get result => _addReviewResult;

  ResultState get state => _state;

  Future<dynamic> postReview(
      String restaurantId, String customerName, String review) async {
    if (customerName.isEmpty || review.isEmpty) {
      _state = ResultState.noData;
      _message = 'Please enter name and review correctly!';
      notifyListeners();
      return;
    }

    try {
      _state = ResultState.loading;
      notifyListeners();
      final reviewResult =
          await apiService.addReview(restaurantId, customerName, review);

      if (reviewResult.customerReviews.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _addReviewResult = reviewResult;
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
}
