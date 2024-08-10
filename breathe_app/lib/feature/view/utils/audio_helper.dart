// lib/utils/audio_helper.dart
import 'package:audioplayers/audioplayers.dart';

class AudioHelper {
  final AudioPlayer _audioPlayer = AudioPlayer();

  Future<void> playBackgroundMusic() async {
    await _audioPlayer.play(AssetSource('audio/rain_sound_1.mp3'), volume: 0.5);
  }

  void dispose() {
    _audioPlayer.dispose();
  }
}
