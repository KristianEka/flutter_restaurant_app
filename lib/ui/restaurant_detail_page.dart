import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:restaurant_app/data/model/restaurant.dart';

class RestaurantDetailPage extends StatelessWidget {
  static const routeName = '/restaurant_detail_page';

  final Restaurant restaurant;

  const RestaurantDetailPage({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, isScrolled) {
          return [
            SliverAppBar(
              pinned: true,
              expandedHeight: 300,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.network(
                  restaurant.pictureId,
                  fit: BoxFit.cover,
                ),
                title: Text(restaurant.name),
                titlePadding: const EdgeInsets.only(
                  left: 56,
                  bottom: 16,
                ),
              ),
            ),
          ];
        },
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                ),
                color: Colors.white10,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.location_pin,
                            size: 16,
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            restaurant.city,
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ],
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
              ),
              Text(restaurant.description)
            ],
          ),
        ),
      ),
    );
  }
}
