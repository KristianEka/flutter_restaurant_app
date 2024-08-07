import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/navigation.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant_detail.dart';
import 'package:restaurant_app/provider/restaurant_detail_provider.dart';
import 'package:restaurant_app/provider/result_state.dart';
import 'package:restaurant_app/ui/restaurant_review_page.dart';
import 'package:restaurant_app/widgets/expandable_text.dart';
import 'package:restaurant_app/widgets/item_card_menu.dart';

class RestaurantDetailPage extends StatelessWidget {
  static const routeName = '/restaurant_detail_page';

  final String restaurantId;

  const RestaurantDetailPage({super.key, required this.restaurantId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (_) => RestaurantDetailProvider(
          apiService: ApiService(),
          restaurantId: restaurantId,
        ),
        child: Consumer<RestaurantDetailProvider>(
          builder: (context, state, _) {
            if (state.state == ResultState.loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.state == ResultState.hasData) {
              var restaurantDetailData = state.result.restaurant;
              return Stack(
                children: [
                  NestedScrollView(
                    headerSliverBuilder: (context, isScrolled) {
                      return [
                        _buildSliverAppBar(
                          restaurantDetailData.id,
                          restaurantDetailData.name,
                          restaurantDetailData.pictureId,
                        ),
                      ];
                    },
                    body: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildRestaurantInfoCard(
                            restaurantDetailData.city,
                            restaurantDetailData.rating,
                            restaurantDetailData.customerReviews,
                            restaurantDetailData.categories,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildDetailSubtitle(
                                    'Description', primaryColor),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ExpandableText(
                                    text: restaurantDetailData.description,
                                    maxLines: 4,
                                  ),
                                ),
                                const Divider(thickness: 3),
                                _buildMenus(restaurantDetailData.menus),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).padding.top + 5,
                    left: 4,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: primaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => Navigation.back(),
                      ),
                    ),
                  ),
                ],
              );
            } else if (state.state == ResultState.noData) {
              return Center(
                child: Text(state.message),
              );
            } else if (state.state == ResultState.error) {
              return Center(
                child: Text(state.message),
              );
            } else {
              return const Center(
                child: Text(''),
              );
            }
          },
        ),
      ),
    );
  }

  SliverAppBar _buildSliverAppBar(
    String restaurantId,
    String restaurantName,
    String pictureId,
  ) {
    return SliverAppBar(
      pinned: true,
      expandedHeight: 300,
      flexibleSpace: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          bool scrolled = constraints.biggest.height <=
              kToolbarHeight + MediaQuery.of(context).padding.top;
          return FlexibleSpaceBar(
            background: Hero(
              tag: restaurantId,
              child: Image.network(
                "https://restaurant-api.dicoding.dev/images/large/$pictureId",
                fit: BoxFit.cover,
                errorBuilder: (ctx, error, _) => const Center(
                  child: Icon(Icons.error),
                ),
              ),
            ),
            title: Container(
              color: scrolled ? null : Colors.black26,
              padding: scrolled
                  ? null
                  : const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: Text(restaurantName),
            ),
            titlePadding: const EdgeInsets.only(left: 56, bottom: 16),
          );
        },
      ),
    );
  }

  Card _buildRestaurantInfoCard(
    String location,
    double rating,
    List<CustomerReview> customerReviews,
    List<Category> category,
  ) {
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
                      location,
                      style:
                          const TextStyle(fontSize: 18, color: onPrimaryColor),
                    ),
                  ],
                ),
                InkWell(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      RatingStars(
                        value: rating,
                        starBuilder: (index, color) => Icon(
                          Icons.star,
                          color: color,
                        ),
                        valueLabelMargin:
                            const EdgeInsets.only(top: 4, right: 4),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        '${customerReviews.length} Reviews',
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
                      customerReviews,
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
                children: category.map((item) {
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

  Widget _buildMenus(Menus menus) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDetailSubtitle('Menus', primaryColor),
        Center(child: _buildDetailSubtitle('Foods', Colors.red)),
        _buildMenuGrid(menus.foods, 'assets/food_placeholder.webp'),
        const Divider(thickness: 2, height: 50),
        Center(child: _buildDetailSubtitle('Drinks', Colors.indigoAccent)),
        _buildMenuGrid(menus.drinks, 'assets/drink_placeholder.webp'),
      ],
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
            color: onPrimaryColor,
          ),
        ),
      ),
    );
  }

  Widget _buildMenuGrid(List<Category> category, String imagePath) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 300,
        child: GridView.count(
          crossAxisCount: 2,
          children: category.map((item) {
            return MenuCard(
              category: item,
              imagePath: imagePath,
            );
          }).toList(),
        ),
      ),
    );
  }
}
