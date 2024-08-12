// lib/screens/meditation_settings_screen.dart
import 'package:breathe_app/core/init/meditation_provider.dart';
import 'package:breathe_app/feature/view/utils/audio_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MeditationSettingsScreen extends StatefulWidget {
  @override
  State<MeditationSettingsScreen> createState() =>
      _MeditationSettingsScreenState();
}

class _MeditationSettingsScreenState extends State<MeditationSettingsScreen> {
  late AudioHelper _audioHelper;

  @override
  void initState() {
    super.initState();
    _audioHelper = AudioHelper();
    _audioHelper.playBackgroundMusic('audio/wave_sound_1.mp3');
  }

  @override
  void dispose() {
    _audioHelper.dispose(); // Dispose çağrılacak
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final provider = Provider.of<MeditationProvider>(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Choose Your Meditate Time',
          style: TextStyle(
              fontSize: screenWidth * 0.06,
              color: Colors.white,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/2.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  provider.meditationTime != null
                      ? 'Meditation Time: ${provider.meditationTime!.format(context)}'
                      : 'No meditation time set',
                  style: TextStyle(
                      fontSize: screenWidth * 0.06, color: Colors.white),
                ),
                SizedBox(height: screenHeight * 0.25),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    side: BorderSide(
                        color: Colors.white, width: screenWidth * 0.003),
                    shape: StadiumBorder(),
                  ),
                  onPressed: () async {
                    TimeOfDay? newTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (newTime != null) {
                      provider.setMeditationTime(newTime);
                      // Handle new time
                    }
                  },
                  child: Text(
                    'Set Meditation Time',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: screenWidth * 0.04,
                        fontWeight: FontWeight.normal),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    side: BorderSide(
                        color: Colors.white, width: screenWidth * 0.003),
                    shape: StadiumBorder(),
                  ),
                  onPressed: () async {
                    await _audioHelper.stopBackgroundMusic();
                    // Proceed to next screen
                  },
                  child: Text(
                    'Next',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: screenWidth * 0.04,
                        fontWeight: FontWeight.normal),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
