import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/favorite/favorite_list_provider.dart';
import 'package:restaurant_app/screen/card/restaurant_card.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  void initState() {
    Future.microtask(() {
      if (!mounted) return;
      context.read<FavoriteListProvider>().getRestaurantFavorite();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Restaurant Favorite')),
      body: Consumer<FavoriteListProvider>(
        builder: (context, value, child) {
          final favoriteRestaurantList = value.restaurants;

          return switch (favoriteRestaurantList.length) {
            0 => const Center(
              child: Text('Daftar Restaurant Favorit Masih Kosong'),
            ),
            _ => ListView.builder(
              itemCount: favoriteRestaurantList.length,
              itemBuilder: (context, index) {
                final restaurant = favoriteRestaurantList[index];

                return RestaurantCard(restaurant: restaurant);
              },
            ),
          };
        },
      ),
    );
  }
}
