import 'package:restaurant_app/data/model/setting/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesServices {
  final SharedPreferences _sharedPreferences;

  SharedPreferencesServices(this._sharedPreferences);

  static const String _keyTheme = 'MY_THEME';
  static const String _keyNotification = 'MY_NOTIFICATION';

  Future<void> setSettingValue({
    bool? isDefaultTheme,
    bool? isNotificationEnabled,
  }) async {
    try {
      if (isDefaultTheme != null && isNotificationEnabled != null) {
        await _sharedPreferences.setBool(_keyTheme, isDefaultTheme);
        await _sharedPreferences.setBool(
          _keyNotification,
          isNotificationEnabled,
        );
      } else if (isDefaultTheme != null) {
        await _sharedPreferences.setBool(_keyTheme, isDefaultTheme);
      } else if (isNotificationEnabled != null) {
        await _sharedPreferences.setBool(
          _keyNotification,
          isNotificationEnabled,
        );
      }
    } catch (_) {
      throw Exception('Shared Preferences cannot save the setting value');
    }
  }

  Settings getSettingValue() {
    return Settings(
      isDefaultTheme: _sharedPreferences.getBool(_keyTheme) ?? true,
      isNotificationEnabled:
          _sharedPreferences.getBool(_keyNotification) ?? true,
    );
  }
}
