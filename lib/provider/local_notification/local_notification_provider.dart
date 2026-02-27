import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:restaurant_app/services/local_notification_services.dart';

class LocalNotificationProvider extends ChangeNotifier {
  final LocalNotificationServices _localNotificationServices;

  LocalNotificationProvider(this._localNotificationServices);

  int _notificationId = 0;
  bool? _permission = false;
  bool? get permission => _permission;
  bool _isEnabled = false;
  bool get isEnabled => _isEnabled;

  List<PendingNotificationRequest> pendingNotificationRequests = [];

  Future<void> requestPermissions() async {
    _permission = await _localNotificationServices.requestPermissions();
    notifyListeners();
  }

  void showNotification() {
    _notificationId += 1;
    _localNotificationServices.showNotification(
      id: _notificationId,
      title: "New Notification",
      body: "This is a new notification with id $_notificationId",
      payload: "This is a payload from notification with id $_notificationId",
    );
  }

  void scheduleDailyElevenAMNotification() async {
    _notificationId += 1;
    _localNotificationServices.scheduleDailyElevenAMNotification(
      id: _notificationId,
    );
  }

  Future<void> checkPendingNotificationRequests() async {
    pendingNotificationRequests = await _localNotificationServices
        .pendingNotificationRequests();
    notifyListeners();
  }

  Future<void> cancelNotification(int id) async {
    await _localNotificationServices.cancelNotification(id);
  }

  Future<void> cancelAllNotification() async {
    try {
      await checkPendingNotificationRequests();
      if (pendingNotificationRequests.isNotEmpty) {
        for (final e in pendingNotificationRequests) {
          cancelNotification(e.id);
        }
      }
      await checkPendingNotificationRequests();
    } catch (_) {
      throw Exception('Gagal Menghapus');
    }
  }

  void notificationEnabledStatus(bool isEnabled) {
    _isEnabled = isEnabled;
    if (_isEnabled) {
      scheduleDailyElevenAMNotification();
    } else {
      cancelAllNotification();
    }
    notifyListeners();
  }
}
