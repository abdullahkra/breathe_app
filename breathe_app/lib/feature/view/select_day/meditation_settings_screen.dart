import 'package:breathe_app/feature/view/payment_page/payment_page.dart';
import 'package:breathe_app/feature/view/videos_preview_page/videos_list.dart';
import 'package:breathe_app/feature/widget/selectDaysWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:day_picker/day_picker.dart';
import 'package:breathe_app/core/init/meditation_provider.dart';
import 'package:breathe_app/feature/view/utils/audio_helper.dart';

class MeditationSettingsScreen extends StatefulWidget {
  final bool isFromSettings; // Yeni parametre

  const MeditationSettingsScreen({Key? key, this.isFromSettings = false})
      : super(key: key);

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
    _audioHelper.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final provider = Provider.of<MeditationProvider>(context);

    List<DayInWeek> _days = provider.days.map((day) {
      return DayInWeek(day,
          isSelected: provider.selectedDays.contains(day), dayKey: '');
    }).toList();

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
              'assets/images/3.jpg',
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
                SizedBox(height: screenHeight * 0.02),
                SizedBox(height: screenHeight * 0.09),
                Padding(
                  padding: EdgeInsets.all(screenWidth * 0.03),
                  child: SelectDaysWidget(
                    fontSize: screenWidth * 0.0335,
                    fontWeight: FontWeight.w500,
                    days: _days,
                    boxDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        colors: [
                          Colors.transparent,
                          Colors.transparent,
                        ],
                        tileMode: TileMode.repeated,
                      ),
                    ),
                    onSelect: (values) {
                      provider.setSelectedDays(values);
                    },
                  ),
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
                    if (widget.isFromSettings) {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => VideosListPage()),
                        (Route<dynamic> route) => false,
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PaymentPage()),
                      );
                    }
                  },
                  child: Text(
                    widget.isFromSettings ? 'Save' : 'Next',
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
