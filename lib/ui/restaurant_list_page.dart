import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/navigation.dart';
import 'package:restaurant_app/provider/restaurant_list_provider.dart';
import 'package:restaurant_app/ui/restaurant_search_page.dart';
import 'package:restaurant_app/utils/result_state.dart';
import 'package:restaurant_app/widgets/custom_refresh.dart';
import 'package:restaurant_app/widgets/restaurant_item.dart';

class RestaurantListPage extends StatelessWidget {
  const RestaurantListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Restaurant App',
        ),
        actions: [
          IconButton(
            onPressed: () => Navigation.intent(RestaurantSearchPage.routeName),
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: _buildList(context),
    );
  }
}

Widget _buildList(BuildContext context) {
  return Consumer<RestaurantListProvider>(
    builder: (context, state, _) {
      if (state.state == ResultState.loading) {
        return const Center(child: CircularProgressIndicator());
      } else if (state.state == ResultState.hasData) {
        return ListView.builder(
          primary: false,
          shrinkWrap: true,
          itemCount: state.result.restaurants.length,
          itemBuilder: (context, index) {
            var restaurant = state.result.restaurants[index];
            return RestaurantItem(restaurant: restaurant);
          },
        );
      } else if (state.state == ResultState.noData) {
        return CustomRefresh(
          message: state.message,
          onClick: () {
            _refreshData(context);
          },
        );
      } else if (state.state == ResultState.error) {
        return CustomRefresh(
          message: state.message,
          onClick: () {
            _refreshData(context);
          },
        );
      } else {
        return CustomRefresh(
          message: '',
          onClick: () {
            _refreshData(context);
          },
        );
      }
    },
  );
}

void _refreshData(BuildContext context) {
  context.read<RestaurantListProvider>().fetchRestaurantList();
}
