import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/model/setting/settings.dart';
import 'package:restaurant_app/provider/home/theme_provider.dart';
import 'package:restaurant_app/provider/shared_preferences/shared_preferences_provider.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  Future<void> themeState() async {
    context.read<SharedPreferencesProvider>().getSettingValue();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(child: const Text("Theme Mode")),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Switch(
                      value: context
                          .watch<SharedPreferencesProvider>()
                          .setting
                          .isDefaultTheme,
                      onChanged: (v) {
                        context
                            .read<SharedPreferencesProvider>()
                            .saveSettingValue(Settings(isDefaultTheme: v));
                        themeState();
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
