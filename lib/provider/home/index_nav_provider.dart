import 'package:flutter/widgets.dart';

class IndexNavProvider extends ChangeNotifier {
  int _indexBottomNavBar = 0;

  int get indexBottomNavbar => _indexBottomNavBar;

  set setIndexBottomNavbar(int value) {
    _indexBottomNavBar = value;
    notifyListeners();
  }
}
