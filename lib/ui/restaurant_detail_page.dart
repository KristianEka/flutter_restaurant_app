import 'package:flutter/material.dart';
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
import 'package:restaurant_app/widgets/restaurant_detail_info_card.dart';

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
              var restaurantDetail = state.result.restaurant;
              return Stack(
                children: [
                  NestedScrollView(
                    headerSliverBuilder: (context, isScrolled) {
                      return [
                        _buildSliverAppBar(restaurantDetail),
                      ];
                    },
                    body: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RestaurantDetailInfoCard(
                            restaurantDetail: restaurantDetail,
                            onClick: () {
                              Navigation.intentWithDataAndReturn(
                                      RestaurantReviewPage.routeName,
                                      restaurantDetail)
                                  ?.then((result) {
                                if (result == true) {
                                  context
                                      .read<RestaurantDetailProvider>()
                                      .fetchRestaurantDetail(
                                          restaurantDetail.id);
                                }
                              });
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildDetailSubtitle(
                                  'Description',
                                  primaryColor,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ExpandableText(
                                    text: restaurantDetail.description,
                                    maxLines: 4,
                                  ),
                                ),
                                const Divider(thickness: 3),
                                _buildMenus(restaurantDetail.menus),
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

  SliverAppBar _buildSliverAppBar(RestaurantDetail restaurantDetail) {
    return SliverAppBar(
      pinned: true,
      expandedHeight: 300,
      flexibleSpace: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          bool scrolled = constraints.biggest.height <=
              kToolbarHeight + MediaQuery.of(context).padding.top;
          return FlexibleSpaceBar(
            background: Hero(
              tag: restaurantDetail.pictureId,
              child: Image.network(
                "https://restaurant-api.dicoding.dev/images/large/${restaurantDetail.pictureId}",
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
              child: Text(restaurantDetail.name),
            ),
            titlePadding: const EdgeInsets.only(left: 56, bottom: 16),
          );
        },
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
