import 'package:flutter/cupertino.dart';
import 'package:restaurant_app/data/model/restaurant/restaurant.dart';
import 'package:restaurant_app/services/sqflite_services.dart';

class FavoriteListProvider extends ChangeNotifier {
  final SqfliteServices _sqfliteServices;
  FavoriteListProvider(this._sqfliteServices);

  List<Restaurant> _restaurants = [];
  List<Restaurant> get restaurants => _restaurants;

  String _message = '';
  String get message => _message;

  Future<void> getRestaurantFavorite() async {
    try {
      final result = await _sqfliteServices.getAllFavouriteRestaurant();
      if (result.isEmpty) {
        _message = 'Daftar Favorit Kosong';
        _restaurants = [];
        notifyListeners();
      } else {
        _restaurants = result;
        _message = 'Berhasil mendapatkan daftar favorit';
        notifyListeners();
      }
    } catch (_) {
      _message = 'Gagal mendapatkan daftar favorit';
      notifyListeners();
    }
  }

  Future<void> addRestaurantFavorite(Restaurant restaurant) async {
    try {
      await _sqfliteServices.insertFavoriteRestaurant(restaurant);
      _message = 'Berhasil menambahkan restaurant ke daftar favorit';
      await getRestaurantFavorite();
    } catch (_) {
      _message = 'Gagal menambahkan restaurant ke daftar favorit';
      notifyListeners();
    }
  }

  Future<void> removeRestaurantFavorite(String id) async {
    try {
      final result = await _sqfliteServices.removeFavoriteRestaurant(id);
      if (result == 1) {
        _message = 'Berhasil menghapus restaurant dari daftar favorit';
        await getRestaurantFavorite();
      } else {
        _message = 'Gagal menghapus restaurant dari daftar favorit';
        notifyListeners();
      }
    } catch (_) {
      _message = 'Gagal menghapus restaurant dari daftar favorit';
      notifyListeners();
    }
  }
}
