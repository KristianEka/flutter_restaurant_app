import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/restaurant_search_provider.dart';
import 'package:restaurant_app/utils/result_state.dart';
import 'package:restaurant_app/widgets/restaurant_item.dart';

class RestaurantSearchPage extends StatefulWidget {
  static const routeName = '/search_page';

  const RestaurantSearchPage({super.key});

  @override
  State<RestaurantSearchPage> createState() => _RestaurantSearchPageState();
}

class _RestaurantSearchPageState extends State<RestaurantSearchPage> {
  late TextEditingController _queryController;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _queryController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _queryController,
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
              onChanged: (value) {
                _onSearchChanged(context, value);
              },
            ),
          ),
          Expanded(
            child: _buildList(context),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _queryController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  _onSearchChanged(BuildContext context, String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      context.read<RestaurantSearchProvider>().fetchSearchRestaurant(query);
    });
  }
}

Widget _buildList(BuildContext context) {
  return Consumer<RestaurantSearchProvider>(
    builder: (context, state, _) {
      if (state.state == ResultState.loading) {
        return const Center(child: CircularProgressIndicator());
      } else if (state.state == ResultState.hasData) {
        return ListView.builder(
          itemCount: state.result.restaurants.length,
          itemBuilder: (context, index) {
            var restaurant = state.result.restaurants[index];
            return RestaurantItem(restaurant: restaurant);
          },
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
          child: Text('No results found'),
        );
      }
    },
  );
}
