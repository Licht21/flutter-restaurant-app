import 'package:flutter/foundation.dart';

class FavoriteProvider extends ChangeNotifier {
  bool _isFavorite = false;
  bool get isFavorite => _isFavorite;

  set setIsFavorite(bool value) {
    _isFavorite = value;
    notifyListeners();
  }
}
