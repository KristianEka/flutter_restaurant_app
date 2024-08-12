import 'package:chat_bubbles/bubbles/bubble_special_one.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/navigation.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/data/model/restaurant_detail.dart';
import 'package:restaurant_app/data/model/review.dart';
import 'package:restaurant_app/provider/add_review_provider.dart';

class RestaurantReviewPage extends StatefulWidget {
  static const routeName = '/review-page';

  final RestaurantDetail restaurantDetail;

  const RestaurantReviewPage({super.key, required this.restaurantDetail});

  @override
  State<RestaurantReviewPage> createState() => _RestaurantReviewPageState();
}

class _RestaurantReviewPageState extends State<RestaurantReviewPage> {
  final _nameController = TextEditingController();

  final _reviewController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<CustomerReview> customerReviews =
        widget.restaurantDetail.customerReviews;
    return Scaffold(
      appBar: AppBar(
        title: Text('Reviews - ${widget.restaurantDetail.name}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          primary: false,
          shrinkWrap: true,
          itemCount: customerReviews.length,
          itemBuilder: (context, index) {
            return _itemReview(customerReviews[index]);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add_comment),
        onPressed: () {
          showDialog(
            context: context,
            builder: (dialogContext) {
              return AlertDialog(
                title: const Text('Add Review'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'Write your name',
                      ),
                    ),
                    const SizedBox(height: 18),
                    TextField(
                      controller: _reviewController,
                      decoration: const InputDecoration(
                        labelText: 'Write your restaurant review',
                      ),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    child: const Text('Submit'),
                    onPressed: () {
                      context
                          .read<AddReviewProvider>()
                          .postReview(
                            widget.restaurantDetail.id,
                            _nameController.text,
                            _reviewController.text,
                          )
                          .whenComplete(() {
                        Navigation.back();
                        Navigation.popWithResult(true);
                      });
                    },
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _reviewController.dispose();
    super.dispose();
  }

  Widget _itemReview(CustomerReview customerReview) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Row(
          children: [
            const Card(
              shape: CircleBorder(),
              margin: EdgeInsets.only(left: 20, right: 12),
              color: secondaryColor,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.person,
                  color: onPrimaryColor,
                ),
              ),
            ),
            Text(
              customerReview.name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 50, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BubbleSpecialOne(
                text: customerReview.review,
                isSender: false,
                color: primaryColor,
                textStyle: const TextStyle(
                  fontSize: 16,
                  color: onPrimaryColor,
                  fontStyle: FontStyle.italic,
                ),
              ),
              Text(customerReview.date),
            ],
          ),
        ),
      ],
    );
  }
}
