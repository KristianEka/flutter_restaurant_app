import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/widgets/item_card_menu.dart';

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
            _buildSliverAppBar(context),
          ];
        },
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildInfoCard(),
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDetailSubtitle('Description', primaryColor),
                    _buildDescription(),
                    const Divider(thickness: 3),
                    _buildMenus(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  SliverAppBar _buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      expandedHeight: 300,
      flexibleSpace: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          bool scrolled = constraints.biggest.height <=
              kToolbarHeight + MediaQuery.of(context).padding.top;
          return FlexibleSpaceBar(
            background: Image.network(
              restaurant.pictureId,
              fit: BoxFit.cover,
            ),
            title: _buildTitle(context, scrolled),
            titlePadding: const EdgeInsets.only(left: 56, bottom: 16),
          );
        },
      ),
    );
  }

  Widget _buildTitle(BuildContext context, bool scrolled) {
    return Container(
      color: scrolled ? null : Colors.black26,
      padding: scrolled
          ? null
          : const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Text(restaurant.name),
    );
  }

  Card _buildInfoCard() {
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildLocationInfo(),
            _buildRatingInfo(),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationInfo() {
    return Row(
      children: [
        const Icon(
          Icons.location_pin,
          size: 16,
          color: onPrimaryColor,
        ),
        const SizedBox(width: 4),
        Text(
          restaurant.city,
          style: const TextStyle(fontSize: 18, color: onPrimaryColor),
        ),
      ],
    );
  }

  Widget _buildRatingInfo() {
    return RatingStars(
      value: restaurant.rating,
      starBuilder: (index, color) => Icon(
        Icons.star,
        color: color,
      ),
      valueLabelMargin: const EdgeInsets.only(top: 4, right: 4),
    );
  }

  Widget _buildDescription() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        restaurant.description,
        maxLines: 4,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildMenus() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDetailSubtitle('Menus', primaryColor),
        Center(child: _buildDetailSubtitle('Foods', Colors.red)),
        _buildMenuGrid(restaurant.menus.foods, 'assets/food_placeholder.webp'),
        const Divider(thickness: 2, height: 50),
        Center(child: _buildDetailSubtitle('Drinks', Colors.indigoAccent)),
        _buildMenuGrid(restaurant.menus.drinks, 'assets/drink_placeholder.png'),
      ],
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
            return MenuCard(category: item, imagePath: imagePath);
          }).toList(),
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
            color: onPrimaryColor,
          ),
        ),
      ),
    );
  }
}
