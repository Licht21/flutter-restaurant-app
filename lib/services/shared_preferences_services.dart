import 'package:restaurant_app/data/model/setting/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesServices {
  final SharedPreferences _sharedPreferences;

  SharedPreferencesServices(this._sharedPreferences);

  static const String _keyTheme = 'MY_THEME';

  Future<void> setSettingValue(Settings setting) async {
    try {
      await _sharedPreferences.setBool(_keyTheme, setting.isDefaultTheme);
    } catch (_) {
      throw Exception('Shared Preferences cannot save the setting value');
    }
  }

  Settings getSettingValue() {
    return Settings(
      isDefaultTheme: _sharedPreferences.getBool(_keyTheme) ?? false,
    );
  }
}
