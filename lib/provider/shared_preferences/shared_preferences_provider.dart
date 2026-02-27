import 'package:flutter/cupertino.dart';
import 'package:restaurant_app/data/model/setting/settings.dart';
import 'package:restaurant_app/services/shared_preferences_services.dart';

class SharedPreferencesProvider extends ChangeNotifier {
  final SharedPreferencesServices _sharedPreferencesServices;

  SharedPreferencesProvider(this._sharedPreferencesServices, this._setting);

  String _message = '';
  String get message => _message;

  Settings _setting;
  Settings get setting => _setting;

  Future<void> saveSettingValue({
    bool? isDefaultTheme,
    bool? isNotificationEnabled,
  }) async {
    try {
      await _sharedPreferencesServices.setSettingValue(
        isDefaultTheme: isDefaultTheme,
        isNotificationEnabled: isNotificationEnabled,
      );
      _message = ' Your data is saved';
    } catch (_) {
      _message = 'Failed to save your data';
    }
    notifyListeners();
  }

  void getSettingValue() async {
    try {
      _setting = _sharedPreferencesServices.getSettingValue();
      _message = 'Data succesfully retrieved';
    } catch (_) {
      _message = 'Failed to get your data';
    }
    notifyListeners();
  }
}
