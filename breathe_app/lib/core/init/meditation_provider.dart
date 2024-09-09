import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class MeditationProvider with ChangeNotifier {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  TimeOfDay? _meditationTime;
  Set<String> _selectedDays = {};

  MeditationProvider() {
    tz.initializeTimeZones();
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('flutter_logo');
    var initializationSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  TimeOfDay? get meditationTime => _meditationTime;
  Set<String> get selectedDays => _selectedDays;

// Bu kısımda 'days' getter'ını ekliyoruz.
  List<String> get days => ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];

  void setMeditationTime(TimeOfDay time) {
    _meditationTime = time;
    notifyListeners();
  }

  void setSelectedDays(List<String> days) {
    _selectedDays = days.where((day) => day.isNotEmpty).toSet();
    notifyListeners();
  }

  void scheduleDailyNotification() {
    if (_meditationTime == null || _selectedDays.isEmpty) return;

    for (String day in _selectedDays) {
      int dayIndex = _getWeekdayIndex(day);
      _scheduleNotification(dayIndex);
    }
  }

  void _scheduleNotification(int weekday) async {
    final time = tz.TZDateTime.now(tz.local)
        .add(
            Duration(days: (weekday - tz.TZDateTime.now(tz.local).weekday) % 7))
        .add(Duration(
            hours: _meditationTime!.hour - tz.TZDateTime.now(tz.local).hour))
        .add(Duration(
            minutes:
                _meditationTime!.minute - tz.TZDateTime.now(tz.local).minute));

    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'meditation_channel_id',
      'Meditation Notifications',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidDetails);

    await flutterLocalNotificationsPlugin.zonedSchedule(
      weekday,
      'Meditation Reminder',
      'It\'s time to meditate!',
      time,
      notificationDetails,
      androidAllowWhileIdle: true,
      matchDateTimeComponents: DateTimeComponents.time,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  int _getWeekdayIndex(String day) {
    if (day.isEmpty) {
      throw ArgumentError('Day cannot be empty');
    }

    switch (day) {
      case 'Sun':
        return DateTime.sunday;
      case 'Mon':
        return DateTime.monday;
      case 'Tue':
        return DateTime.tuesday;
      case 'Wed':
        return DateTime.wednesday;
      case 'Thu':
        return DateTime.thursday;
      case 'Fri':
        return DateTime.friday;
      case 'Sat':
        return DateTime.saturday;
      default:
        throw ArgumentError('Invalid day: $day');
    }
  }
}
