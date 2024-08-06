import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/provider/restaurant_search_provider.dart';
import 'package:restaurant_app/provider/result_state.dart';
import 'package:restaurant_app/widgets/restaurant_item.dart';

class RestaurantSearchPage extends StatelessWidget {
  static const routeName = '/search_page';

  RestaurantSearchPage({super.key});

  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RestaurantSearchProvider(
        apiService: ApiService(),
        query: searchController.text = "",
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Search'),
        ),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: searchController,
                textInputAction: TextInputAction.search,
                autofocus: true,
                maxLines: 1,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: const BorderSide(color: Colors.black87),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: const BorderSide(color: Colors.black87),
                  ),
                  suffixIcon: const Icon(Icons.search),
                  hintText: 'Write the name of restaurant ...',
                ),
                onSubmitted: (value) {
                  searchController.text = value;
                },
                onChanged: (value) {
                  searchController.text = value;
                },
              ),
            ),
            _buildList(context),
          ],
        ),
      ),
    );
  }
}

Widget _buildList(BuildContext context) {
  return Consumer<RestaurantSearchProvider>(
    builder: (context, state, _) {
      if (state.state == ResultState.loading) {
        return const Center(child: CircularProgressIndicator());
      } else if (state.state == ResultState.hasData) {
        return Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: state.result.restaurants.length,
            itemBuilder: (context, index) {
              var restaurant = state.result.restaurants[index];
              return RestaurantItem(restaurant: restaurant);
            },
          ),
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
  );
}
