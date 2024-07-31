import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/ui/restaurant_detail_page.dart';

class RestaurantListPage extends StatelessWidget {
  const RestaurantListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Restaurant App',
        ),
      ),
      body: _buildList(context),
    );
  }
}

Widget _buildList(BuildContext context) {
  return FutureBuilder(
    future: DefaultAssetBundle.of(context)
        .loadString('assets/local_restaurant.json'),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        final List<Restaurant> restaurants = parsedRestaurants(snapshot.data);
        return ListView.builder(
            itemCount: restaurants.length,
            itemBuilder: (context, index) {
              return _buildRestaurantItem(context, restaurants[index]);
            });
      } else {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
    },
  );
}

Widget _buildRestaurantItem(BuildContext context, Restaurant restaurant) {
  return InkWell(
    onTap: () {
      Navigator.pushNamed(
        context,
        RestaurantDetailPage.routeName,
        arguments: restaurant,
      );
    },
    child: Card(
      clipBehavior: Clip.antiAlias,
      elevation: 5,
      child: Row(
        children: [
          Image.network(
            restaurant.pictureId,
            fit: BoxFit.cover,
            width: 135,
            height: 100,
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
