import 'package:breathe_app/feature/view/select_day/meditation_settings_screen.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Privacy Policy'),
            onTap: () {
              // Gizlilik sözleşmesi sayfasına yönlendirme yapılabilir
            },
          ),
          ListTile(
            title: Text('Notification Settings'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      MeditationSettingsScreen(isFromSettings: true),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
