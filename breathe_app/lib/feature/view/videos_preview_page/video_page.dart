import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'dart:async';

class VideoPage extends StatefulWidget {
  final String videoUrl;
  final String title;

  VideoPage({required this.videoUrl, required this.title});

  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  late VideoPlayerController _controller;
  Timer? _timer;
  int _seconds = 0;
  bool _isTimerRunning = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {}); // Video yüklendiğinde yeniden build edilir.
        _controller.play(); // Video otomatik olarak oynatılır.
        _controller.setLooping(true); // Videoyu döngüde tut
      });

    // Döngü sırasında kesinti olmaması için bir listener ekleyin
    _controller.addListener(() {
      if (_controller.value.position == _controller.value.duration) {
        _controller.seekTo(Duration.zero);
        _controller.play(); // Tekrar başlat
      }
    });
  }

  @override
  void dispose() {
    _controller.removeListener(() {}); // Dinleyiciyi kaldırın
    _controller.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _toggleTimer() {
    if (_isTimerRunning) {
      _timer?.cancel();
    } else {
      _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
        setState(() {
          _seconds++;
        });
      });
    }
    setState(() {
      _isTimerRunning = !_isTimerRunning;
    });
  }

  String _formatTime(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$secs';
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          _controller.value.isInitialized
              ? Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: SizedBox(
                      width: _controller.value.size.width,
                      height: _controller.value.size.height,
                      child: VideoPlayer(_controller),
                    ),
                  ),
                )
              : Center(child: CircularProgressIndicator()),
          Center(
            child: GestureDetector(
              onTap: _toggleTimer,
              child: Container(
                width: screenWidth * 0.4,
                height: screenHeight * 0.4,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.transparent,
                  border: Border.all(
                      color: Colors.white, width: screenWidth * 0.01),
                ),
                alignment: Alignment.center,
                child: Text(
                  _formatTime(_seconds),
                  style: TextStyle(
                    color: const Color.fromARGB(255, 255, 255, 255),
                    backgroundColor: const Color.fromARGB(90, 0, 0, 0),
                    fontSize: screenWidth * 0.07,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
