import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/restaurant/restaurant.dart';
import 'package:restaurant_app/static/navigation_route.dart';

class RestaurantDetailScreen extends StatefulWidget {
  final Restaurant restaurant;
  const RestaurantDetailScreen({super.key, required this.restaurant});

  @override
  State<RestaurantDetailScreen> createState() => _RestaurantDetailScreenState();
}

class _RestaurantDetailScreenState extends State<RestaurantDetailScreen> {
  @override
  Widget build(BuildContext context) {
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
                  Text(
                    widget.restaurant.name,
                    style: Theme.of(context).textTheme.titleMedium,
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
