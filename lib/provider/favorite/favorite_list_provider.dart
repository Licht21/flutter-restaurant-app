import 'package:flutter/cupertino.dart';
import 'package:restaurant_app/data/model/restaurant/restaurant.dart';
import 'package:restaurant_app/services/sqflite_services.dart';

class FavoriteListProvider extends ChangeNotifier {
  final SqfliteServices _sqfliteServices;
  FavoriteListProvider(this._sqfliteServices);

  List<Restaurant> _restaurants = [];
  List<Restaurant> get restaurants => _restaurants;

  Restaurant? _restaurant;
  Restaurant? get restaurant => _restaurant;

  String _message = '';
  String get message => _message;

  Future<void> getRestaurantFavorite() async {
    try {
      final result = await _sqfliteServices.getAllFavouriteRestaurant();
      if (result.isEmpty) {
        _message = 'Daftar Favorit Kosong';
        _restaurants = [];
      } else {
        _restaurants = result;
        _restaurant = null;
        _message = 'Berhasil mendapatkan daftar favorit';
      }
    } catch (_) {
      _message = 'Gagal mendapatkan daftar favorit';
    }
    notifyListeners();
  }

  Future<void> addRestaurantFavorite(Restaurant restaurant) async {
    try {
      final result = await _sqfliteServices.insertFavoriteRestaurant(
        restaurant,
      );

      final isError = result == 0;
      if (isError) {
        _message = 'Gagal menambahkan restaurant ke daftar favorit';
      } else {
        _message = 'Berhasil menambahkan restaurant ke daftar favorit';
      }
    } catch (_) {
      _message = 'Gagal menambahkan restaurant ke daftar favorit';
    }
    notifyListeners();
  }

  Future<void> removeRestaurantFavorite(String id) async {
    try {
      final result = await _sqfliteServices.removeFavoriteRestaurant(id);
      if (result == 1) {
        _message = 'Berhasil menghapus restaurant dari daftar favorit';
      } else {
        _message = 'Gagal menghapus restaurant dari daftar favorit';
        notifyListeners();
      }
    } catch (_) {
      _message = 'Gagal menghapus restaurant dari daftar favorit';
      notifyListeners();
    }
  }

  Future<void> loadRestaurantById(String id) async {
    try {
      _restaurant = await _sqfliteServices.getRestaurantByID(id);
      _message = 'Berhasil mendapatkan data restaurant';
    } catch (_) {
      _message = 'Gagal mendapatkan data restaurant';
    }
    notifyListeners();
  }

  bool checkItemFavorite(String id) {
    final isSameRestaurant = _restaurant?.id == id;
    return isSameRestaurant;
  }
}
