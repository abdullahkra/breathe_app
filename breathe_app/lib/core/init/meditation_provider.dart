import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class MeditationProvider with ChangeNotifier {
  TimeOfDay? _meditationTime;
  List<String> days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
  Set<String> _selectedDays = {};
  String? _fcmToken;

  MeditationProvider() {
    _initializeFirebaseMessaging();
  }

  TimeOfDay? get meditationTime => _meditationTime;
  Set<String> get selectedDays => _selectedDays;
  String? get fcmToken => _fcmToken;

  // Firebase Messaging'i başlatma ve token alma
  void _initializeFirebaseMessaging() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    // FCM token al
    messaging.getToken().then((token) {
      _fcmToken = token;
      print("FCM Token: $token");
      notifyListeners();
    });

    // Mesaj dinleyicileri
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Message data: ${message.data}');
      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
    });
  }

  void setMeditationTime(TimeOfDay time) {
    _meditationTime = time;
    notifyListeners();
  }

  void setSelectedDays(List<String> days) {
    _selectedDays = days.toSet();
    notifyListeners();
  }

  void saveSettings() {
    // Kullanıcı ayarlarını kaydetmek için kullanılacak
  }

  // Firebase Cloud Functions ile push notification tetiklemek için kullanılabilir
  void scheduleNotifications() {
    // Seçilen gün ve saate göre Firebase'e push notification talebi yapılabilir.
  }
}
