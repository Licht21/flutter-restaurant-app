import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDefaultTheme = false;

  bool get isDefaultTheme => _isDefaultTheme;

  set isDefaultTheme(bool value) {
    _isDefaultTheme = value;
    notifyListeners();
  }
}
