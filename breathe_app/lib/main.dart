import 'package:breathe_app/core/init/meditation_provider.dart';
import 'package:breathe_app/feature/view/get_started/get_started_screen.dart';
import 'package:breathe_app/feature/view/videos_preview_page/videos_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MeditationApp());
}

class MeditationApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MeditationProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: FutureBuilder<bool>(
          future: _isInitialSetupComplete(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator(); // Bir yüklenme ekranı gösterilebilir
            } else {
              return snapshot.data == true
                  ? VideosListPage()
                  : GetStartedScreen();
            }
          },
        ),
      ),
    );
  }

  Future<bool> _isInitialSetupComplete() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('initialSetupComplete') ?? false;
  }
}
