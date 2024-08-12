// lib/utils/audio_helper.dart
import 'package:audioplayers/audioplayers.dart';

class AudioHelper {
  final AudioPlayer _audioPlayer = AudioPlayer();

  Future<void> playBackgroundMusic(String assetPath) async {
    await _audioPlayer.stop(); // Önce mevcut müziği durdur
    await _audioPlayer.play(AssetSource(assetPath), volume: 0.5);
  }

  Future<void> stopBackgroundMusic() async {
    await _audioPlayer.stop(); // Müziği durdur
  }

  void dispose() {
    _audioPlayer.dispose();
  }
}
