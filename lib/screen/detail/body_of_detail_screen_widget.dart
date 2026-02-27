import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/model/restaurant/restaurant_detail_response.dart';
import 'package:restaurant_app/provider/home/theme_provider.dart';
import 'package:restaurant_app/screen/favorite/favorite_icon.dart';

class BodyOfDetailScreenWidget extends StatefulWidget {
  final RestaurantDetail restaurant;
  const BodyOfDetailScreenWidget({super.key, required this.restaurant});

  @override
  State<BodyOfDetailScreenWidget> createState() =>
      _BodyOfDetailScreenWidgetState();
}

class _BodyOfDetailScreenWidgetState extends State<BodyOfDetailScreenWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsetsGeometry.symmetric(
          vertical: 8,
          horizontal: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text('Add Favorite'),
                FavoriteIcon(restaurant: widget.restaurant),
              ],
            ),
            Hero(
              tag: widget.restaurant.pictureId,
              child: Image.network(
                "https://restaurant-api.dicoding.dev/images/medium/${widget.restaurant.pictureId}",
              ),
            ),
            const SizedBox.square(dimension: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    widget.restaurant.name,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Icon(Icons.star),
                      Text(
                        widget.restaurant.rating.toString(),
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox.square(dimension: 8),
            Row(
              children: [
                const Icon(Icons.pin_drop),
                const SizedBox.square(dimension: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.restaurant.city,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      widget.restaurant.address,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox.square(dimension: 8),
            Text(
              widget.restaurant.description,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox.square(dimension: 16),
            Text('Foods', style: Theme.of(context).textTheme.bodyLarge),
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.restaurant.menus.foods.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 100,
                      decoration: BoxDecoration(
                        color: context.read<ThemeProvider>().isDefaultTheme
                            ? Colors.black
                            : Colors.white,
                        borderRadius: BorderRadiusGeometry.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.restaurant.menus.foods[index].name,
                          style: Theme.of(context).textTheme.labelLarge
                              ?.copyWith(
                                color:
                                    context.read<ThemeProvider>().isDefaultTheme
                                    ? Colors.white
                                    : Colors.black,
                              ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox.square(dimension: 16),
            Text('Drinks', style: Theme.of(context).textTheme.bodyLarge),
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.restaurant.menus.drinks.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 100,
                      decoration: BoxDecoration(
                        color: context.read<ThemeProvider>().isDefaultTheme
                            ? Colors.black
                            : Colors.white,
                        borderRadius: BorderRadiusGeometry.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.restaurant.menus.drinks[index].name,
                          style: Theme.of(context).textTheme.labelLarge
                              ?.copyWith(
                                color:
                                    context.read<ThemeProvider>().isDefaultTheme
                                    ? Colors.white
                                    : Colors.black,
                              ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
