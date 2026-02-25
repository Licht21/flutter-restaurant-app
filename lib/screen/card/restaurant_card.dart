import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/model/restaurant/restaurant.dart';
import 'package:restaurant_app/provider/favorite/favorite_list_provider.dart';
import 'package:restaurant_app/static/navigation_route.dart';

class RestaurantCard extends StatefulWidget {
  final Restaurant restaurant;
  const RestaurantCard({super.key, required this.restaurant});

  @override
  State<RestaurantCard> createState() => _RestaurantCardState();
}

class _RestaurantCardState extends State<RestaurantCard> {
  bool isFavorite = false;

  void isFavoriteRestaurant() {
    setState(() {
      isFavorite = context.read<FavoriteListProvider>().restaurants.any(
        (e) => e.id == widget.restaurant.id,
      );
    });
  }

  @override
  void initState() {
    super.initState();
    isFavoriteRestaurant();
  }

  @override
  Widget build(BuildContext context) {
    isFavoriteRestaurant();
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          NavigationRoute.detailRoute.name,
          arguments: widget.restaurant.id,
        );
      },
      child: Padding(
        padding: const EdgeInsetsGeometry.symmetric(
          vertical: 8,
          horizontal: 16,
        ),
        child: Row(
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(
                maxHeight: 80,
                minHeight: 80,
                maxWidth: 120,
                minWidth: 120,
              ),
              child: ClipRRect(
                borderRadius: BorderRadiusGeometry.circular(10),
                child: Hero(
                  tag: widget.restaurant.pictureId,
                  child: Image.network(
                    'https://restaurant-api.dicoding.dev/images/medium/${widget.restaurant.pictureId}',
                  ),
                ),
              ),
            ),
            const SizedBox.square(dimension: 10),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        flex: 5,
                        child: Text(
                          widget.restaurant.name,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: IconButton(
                          onPressed: () {
                            isFavorite
                                ? context
                                      .read<FavoriteListProvider>()
                                      .removeRestaurantFavorite(
                                        widget.restaurant.id,
                                      )
                                : context
                                      .read<FavoriteListProvider>()
                                      .addRestaurantFavorite(widget.restaurant);
                          },
                          icon: isFavorite
                              ? Icon(Icons.favorite)
                              : Icon(Icons.favorite_border),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox.square(dimension: 4),
                  Row(
                    children: [
                      const Icon(Icons.pin_drop),
                      const SizedBox.square(dimension: 4),
                      Expanded(
                        child: Text(
                          widget.restaurant.city,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.star_purple500_outlined),
                      const SizedBox.square(dimension: 4),
                      Expanded(
                        child: Text(widget.restaurant.rating.toString()),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
