import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/local_notification/local_notification_provider.dart';
import 'package:restaurant_app/provider/shared_preferences/shared_preferences_provider.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  Future<void> settingState() async {
    context.read<SharedPreferencesProvider>().getSettingValue();
  }

  Future<void> _requestPermission() async {
    context.read<LocalNotificationProvider>().requestPermissions();
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
                            .saveSettingValue(isDefaultTheme: v);
                        settingState();
                      },
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox.square(dimension: 8),
            Row(
              children: [
                Expanded(child: const Text("Notification Reminder")),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Switch(
                      value: context
                          .watch<SharedPreferencesProvider>()
                          .setting
                          .isNotificationEnabled,
                      onChanged: (v) {
                        context
                            .read<SharedPreferencesProvider>()
                            .saveSettingValue(isNotificationEnabled: v);
                        context
                            .read<LocalNotificationProvider>()
                            .notificationEnabledStatus(v);
                        settingState();
                      },
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox.square(dimension: 8),
            Row(
              children: [
                Expanded(child: const Text('Notification Permission Status')),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      await _requestPermission();
                    },
                    child: Consumer<LocalNotificationProvider>(
                      builder: (context, value, child) {
                        return Text(
                          'Permission ${value.permission ?? false ? 'Granted' : 'Not Granted'}',
                          style: Theme.of(context).textTheme.bodySmall,
                        );
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
