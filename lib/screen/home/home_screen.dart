import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/favorite/favorite_list_provider.dart';
import 'package:restaurant_app/provider/home/restaurant_list_provider.dart';
import 'package:restaurant_app/provider/home/theme_provider.dart';
import 'package:restaurant_app/screen/card/restaurant_card.dart';
import 'package:restaurant_app/static/restaurant_list_result_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<RestaurantListProvider>().fetchRestaurantList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurant Apps'),
        actions: [
          context.read<ThemeProvider>().isDefaultTheme
              ? const Icon(Icons.sunny)
              : const Icon(Icons.nightlight),
        ],
      ),
      body: Consumer<RestaurantListProvider>(
        builder: (context, value, child) {
          return switch (value.resultState) {
            RestaurantListLoadingState() => const Center(
              child: CircularProgressIndicator(),
            ),
            RestaurantListLoadedState(data: var restaurantList) =>
              ListView.builder(
                itemCount: restaurantList.length,
                itemBuilder: (context, index) {
                  final restaurant = restaurantList[index];

                  return Consumer<FavoriteListProvider>(
                    builder: (context, value, widget) {
                      return RestaurantCard(restaurant: restaurant);
                    },
                  );
                },
              ),
            RestaurantListErrorState(error: var message) => Center(
              child: Text(message),
            ),
            _ => const SizedBox(),
          };
        },
      ),
    );
  }
}
