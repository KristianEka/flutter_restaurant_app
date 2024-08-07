import 'package:chat_bubbles/bubbles/bubble_special_one.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant_detail.dart';
import 'package:restaurant_app/data/model/review.dart';
import 'package:restaurant_app/provider/add_review_provider.dart';
import 'package:restaurant_app/widgets/restaurant_detail_info_card.dart';

class RestaurantReviewPage extends StatelessWidget {
  static const routeName = '/review-page';

  final RestaurantDetail restaurantDetail;

  RestaurantReviewPage({super.key, required this.restaurantDetail});

  final nameController = TextEditingController();

  final reviewController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AddReviewProvider(apiService: ApiService()),
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Reviews - ${restaurantDetail.name}'),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RestaurantDetailInfoCard(
                  restaurantDetail: restaurantDetail,
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Customer Reviews',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: restaurantDetail.customerReviews.length,
                  itemBuilder: (context, index) {
                    return _itemReview(restaurantDetail.customerReviews[index]);
                  },
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add_comment),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context1) {
                  return AlertDialog(
                    title: const Text('Add Review'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: nameController,
                          decoration: const InputDecoration(
                            labelText: 'Write your name',
                          ),
                        ),
                        const SizedBox(height: 18),
                        TextField(
                          controller: reviewController,
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
                          context.read<AddReviewProvider>().postReview(
                                restaurantDetail.id,
                                nameController.text,
                                reviewController.text,
                              );
                          var newData = context
                              .read<AddReviewProvider>()
                              .result
                              .customerReviews;

                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: newData.length,
                            itemBuilder: (context, index) {
                              return _itemReview(newData[index]);
                            },
                          );
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        );
      },
    );
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
