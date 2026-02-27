import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/model/restaurant/restaurant.dart';
import 'package:restaurant_app/data/model/restaurant/restaurant_detail_response.dart';
import 'package:restaurant_app/provider/favorite/favorite_list_provider.dart';
import 'package:restaurant_app/provider/favorite/favorite_provider.dart';

class FavoriteIcon extends StatefulWidget {
  final RestaurantDetail restaurant;
  const FavoriteIcon({super.key, required this.restaurant});

  @override
  State<FavoriteIcon> createState() => _FavoriteIconState();
}

class _FavoriteIconState extends State<FavoriteIcon> {
  @override
  void initState() {
    final favoriteListProvider = context.read<FavoriteListProvider>();
    final favoriteProvider = context.read<FavoriteProvider>();

    Future.microtask(() async {
      await favoriteListProvider.loadRestaurantById(widget.restaurant.id);
      final value = favoriteListProvider.checkItemFavorite(
        widget.restaurant.id,
      );
      favoriteProvider.isFavorite = value;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        final favoriteListProvider = context.read<FavoriteListProvider>();
        final favoriteProvider = context.read<FavoriteProvider>();
        final isFavorite = favoriteProvider.isFavorite;

        if (!isFavorite) {
          await favoriteListProvider.addRestaurantFavorite(
            Restaurant(
              id: widget.restaurant.id,
              name: widget.restaurant.name,
              description: widget.restaurant.description,
              pictureId: widget.restaurant.pictureId,
              city: widget.restaurant.city,
              rating: widget.restaurant.rating,
            ),
          );
        } else {
          favoriteListProvider.removeRestaurantFavorite(widget.restaurant.id);
        }
        favoriteProvider.isFavorite = !isFavorite;
        favoriteListProvider.getRestaurantFavorite();
      },
      icon: context.watch<FavoriteProvider>().isFavorite
          ? Icon(Icons.favorite)
          : Icon(Icons.favorite_border),
    );
  }
}
