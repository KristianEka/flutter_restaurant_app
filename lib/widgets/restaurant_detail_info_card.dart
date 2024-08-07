import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:restaurant_app/common/navigation.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/data/model/restaurant_detail.dart';
import 'package:restaurant_app/ui/restaurant_review_page.dart';

class RestaurantDetailInfoCard extends StatelessWidget {
  final RestaurantDetail restaurantDetail;

  const RestaurantDetailInfoCard({
    super.key,
    required this.restaurantDetail,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
      ),
      color: secondaryColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.location_pin,
                      size: 16,
                      color: onPrimaryColor,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      restaurantDetail.city,
                      style: const TextStyle(
                        fontSize: 18,
                        color: onPrimaryColor,
                      ),
                    ),
                  ],
                ),
                InkWell(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      RatingStars(
                        value: restaurantDetail.rating,
                        starBuilder: (index, color) => Icon(
                          Icons.star,
                          color: color,
                        ),
                        valueLabelMargin:
                            const EdgeInsets.only(top: 4, right: 4),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        '${restaurantDetail.customerReviews.length} Reviews',
                        style: const TextStyle(
                          color: onPrimaryColor,
                          fontSize: 11.0,
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigation.intentWithData(
                      RestaurantReviewPage.routeName,
                      restaurantDetail,
                    );
                  },
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, top: 5),
              child: Wrap(
                spacing: 8,
                runSpacing: 6,
                children: restaurantDetail.categories.map((item) {
                  return Chip(
                    label: Text(item.name),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
