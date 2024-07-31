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
              flexibleSpace: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  // Check if the FlexibleSpaceBar has scrolled to the title area
                  bool scrolled = constraints.biggest.height <=
                      kToolbarHeight + MediaQuery.of(context).padding.top;
                  return FlexibleSpaceBar(
                    background: Image.network(
                      restaurant.pictureId,
                      fit: BoxFit.cover,
                    ),
                    title: Container(
                      color: scrolled ? null : Colors.black26,
                      padding: scrolled
                          ? null
                          : const EdgeInsets.symmetric(
                              horizontal: 8.0,
                              vertical: 4.0,
                            ),
                      child: Text(
                        restaurant.name,
                      ),
                    ),
                    titlePadding: const EdgeInsets.only(
                      left: 56,
                      bottom: 16,
                    ),
                  );
                },
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
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDetailSubtitle('Description', Colors.black26),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        restaurant.description,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const Divider(
                      thickness: 3,
                    ),
                    _buildDetailSubtitle('Menus', Colors.black26),
                    Center(
                      child: _buildDetailSubtitle('Foods', Colors.redAccent),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 300,
                        child: GridView.count(
                          crossAxisCount: 2,
                          children: restaurant.menus.foods.map((food) {
                            return Card(
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Flexible(
                                    flex: 2,
                                    child: Image.asset(
                                      'assets/food_placeholder.webp',
                                      height: 100,
                                      width: 100,
                                    ),
                                  ),
                                  Flexible(
                                    flex: 1,
                                    child: Text(food.name),
                                  )
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    const Divider(
                      thickness: 2,
                      height: 50,
                    ),
                    Center(
                      child:
                          _buildDetailSubtitle('Drinks', Colors.indigoAccent),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 300,
                        child: GridView.count(
                          crossAxisCount: 2,
                          children: restaurant.menus.drinks.map((drink) {
                            return Card(
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Flexible(
                                    flex: 2,
                                    child: Image.asset(
                                      'assets/drink_placeholder.png',
                                      height: 100,
                                      width: 100,
                                    ),
                                  ),
                                  Flexible(
                                    flex: 1,
                                    child: Text(drink.name),
                                  )
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Card _buildDetailSubtitle(String titleName, Color color) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: color,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          titleName,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
