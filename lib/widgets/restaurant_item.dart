import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:restaurant_app/common/navigation.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/ui/restaurant_detail_page.dart';

class RestaurantItem extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantItem({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigation.intentWithData(
          RestaurantDetailPage.routeName,
          restaurant.id,
        );
      },
      highlightColor: onPrimaryColor,
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 5,
        child: Row(
          children: [
            Hero(
              tag: restaurant.pictureId,
              child: Image.network(
                'https://restaurant-api.dicoding.dev/images/small/${restaurant.pictureId}',
                fit: BoxFit.cover,
                width: 135,
                height: 100,
                errorBuilder: (ctx, error, _) => const Center(
                  child: Icon(Icons.error),
                ),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    restaurant.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_pin,
                        size: 16,
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(restaurant.city),
                    ],
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  RatingStars(
                    value: restaurant.rating,
                    starBuilder: (index, color) => Icon(
                      Icons.star,
                      color: color,
                    ),
                    valueLabelMargin: const EdgeInsets.only(
                      top: 6,
                      right: 8,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
