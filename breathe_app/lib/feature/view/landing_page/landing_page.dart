import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../get_started/get_started_screen.dart';
import '../videos_preview_page/videos_list.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  void initState() {
    super.initState();
    _navigateToNextPage();
  }

  Future<void> _navigateToNextPage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isInitialSetupComplete =
        prefs.getBool('initialSetupComplete') ?? false;

    // Bir süre bekleyelim (Örneğin 2 saniye), bu süre boyunca uygulama logosu gösterilecek
    await Future.delayed(Duration(seconds: 2));

    if (isInitialSetupComplete) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => VideosListPage()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => GetStartedScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    /* final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width; */
    return Scaffold(
      body: Center(
        child: ClipOval(
          child: Image.asset(
            'assets/images/Breathe.png',
            fit: BoxFit.cover,
          ), // Uygulama logosunu buraya koyabilirsiniz
        ),
      ),
    );
  }
}
