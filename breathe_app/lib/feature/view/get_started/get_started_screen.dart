// lib/screens/get_started_screen.dart
import 'package:breathe_app/feature/view/select_day/meditation_settings_screen.dart';
import 'package:breathe_app/feature/view/utils/audio_helper.dart';
import 'package:flutter/material.dart';

class GetStartedScreen extends StatefulWidget {
  const GetStartedScreen({super.key});

  @override
  _GetStartedScreenState createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen>
    with SingleTickerProviderStateMixin {
  double _opacity = 0.0;
  late AudioHelper _audioHelper;

  @override
  void initState() {
    super.initState();
    _audioHelper = AudioHelper();
    _audioHelper.playBackgroundMusic('audio/rain_sound_1.mp3');
    _fadeInText();
  }

  void _fadeInText() {
    Future.delayed(
      Duration(seconds: 2),
      () {
        setState(
          () {
            _opacity = 1.0;
          },
        );
      },
    );
  }

  @override
  void dispose() {
    _audioHelper.dispose(); // Dispose çağrılacak
    super.dispose(); // Kaynakları serbest bırak
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
            child: Image.asset(
              'assets/images/1.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: screenHeight * 0.15,
            left: 0,
            right: 0,
            child: AnimatedOpacity(
              opacity: _opacity,
              duration: Duration(seconds: 2),
              child: Text(
                'Hello',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: screenWidth * 0.07,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ),
          Positioned(
            top: screenHeight * 0.23,
            left: 0,
            right: 0,
            child: AnimatedOpacity(
              opacity: _opacity,
              duration: Duration(seconds: 5),
              child: Text(
                "Let's start relaxing",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: screenWidth * 0.07,
                    fontWeight: FontWeight.normal),
              ),
            ),
          ),
          Positioned(
            bottom: screenHeight * 0.1,
            left: screenWidth * 0.38,
            right: screenWidth * 0.38,
            child: AnimatedOpacity(
                opacity: _opacity,
                duration: Duration(seconds: 7),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    side: BorderSide(
                        color: Colors.white, width: screenWidth * 0.003),
                    shape: StadiumBorder(),
                  ),
                  onPressed: () async {
                    await _audioHelper.stopBackgroundMusic();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MeditationSettingsScreen()),
                    );
                  },
                  child: Text(
                    "Start",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: screenWidth * 0.05,
                        fontWeight: FontWeight.w300),
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
