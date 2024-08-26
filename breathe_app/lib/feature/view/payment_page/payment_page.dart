import 'package:breathe_app/feature/view/utils/audio_helper.dart';
import 'package:breathe_app/feature/view/videos_preview_page/videos_list.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  late AudioHelper _audioHelper;

  @override
  void initState() {
    super.initState();
    _audioHelper = AudioHelper();
    _audioHelper.playBackgroundMusic('audio/forest_sound_1.mp3');
  }

  @override
  void dispose() {
    _audioHelper.dispose();
    super.dispose();
  }

  Future<void> _completeSetup() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('initialSetupComplete', true);
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Choose Your Plan",
          style: TextStyle(
              fontSize: screenWidth * 0.08,
              color: const Color.fromARGB(255, 255, 255, 255),
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Stack(
        children: [
          SizedBox.expand(
            child: Image.asset(
              "assets/images/4.jpg",
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: screenHeight * 0.4,
            left: screenWidth * 0.13,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(1, 0, 0, 0.3),
                side:
                    BorderSide(color: Colors.white, width: screenWidth * 0.002),
                shape: StadiumBorder(),
              ),
              onPressed: () async {
                await _audioHelper.stopBackgroundMusic();
              },
              child: Text(
                "1 Month (3\$)",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: screenWidth * 0.04,
                ),
              ),
            ),
          ),
          Positioned(
            top: screenHeight * 0.4,
            right: screenWidth * 0.13,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(1, 0, 0, 0.3),
                side:
                    BorderSide(color: Colors.white, width: screenWidth * 0.002),
                shape: StadiumBorder(),
              ),
              onPressed: () async {
                await _audioHelper.stopBackgroundMusic();
              },
              child: Text(
                "1 Year (30\$)",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: screenWidth * 0.04,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: screenHeight * 0.15,
            left: 0,
            right: 0,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                side:
                    BorderSide(color: Colors.white, width: screenWidth * 0.002),
                shape: StadiumBorder(),
              ),
              onPressed: () async {
                await _audioHelper.stopBackgroundMusic();
                await _completeSetup(); // Setup tamamlandığında bu metodu çağırıyoruz
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => VideosListPage()),
                );
              },
              child: Text(
                'No Thanks (Go Limited Free Version With Ads)',
                style: TextStyle(
                  fontSize: screenWidth * 0.035,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
