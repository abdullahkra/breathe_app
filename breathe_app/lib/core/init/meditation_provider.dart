import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class MeditationProvider with ChangeNotifier {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  TimeOfDay? _meditationTime;
  List<String> days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
  Set<String> _selectedDays = {};

  MeditationProvider() {
    var initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = DarwinInitializationSettings();
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  TimeOfDay? get meditationTime => _meditationTime;
  Set<String> get selectedDays => _selectedDays;

  void setMeditationTime(TimeOfDay time) {
    _meditationTime = time;
    notifyListeners();
  }

  void setSelectedDays(List<String> days) {
    _selectedDays = days.toSet();
    notifyListeners();
  }

  void saveSettings() {
    // Save settings to persistent storage
  }

  void scheduleDailyNotification(TimeOfDay newTime) {}

  void scheduleNotifications() {}
}