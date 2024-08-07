import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/restaurant_detail.dart';

class RestaurantReviewPage extends StatefulWidget {
  static const routeName = '/review-page';

  final List<CustomerReview> customerReview;

  const RestaurantReviewPage({super.key, required this.customerReview});

  @override
  State<RestaurantReviewPage> createState() => _RestaurantReviewPageState();
}

class _RestaurantReviewPageState extends State<RestaurantReviewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customer Reviews'),
      ),
      body: Text(widget.customerReview[0].name),
    );
  }
}
