import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Asset'leri okumak için
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:path_provider/path_provider.dart'; // Geçici dosyalar için

class VideoThumbnailPage extends StatefulWidget {
  final String videoPath; // Asset veya dosya yolunu belirt
  final String title;

  VideoThumbnailPage({required this.videoPath, required this.title});

  @override
  _VideoThumbnailPageState createState() => _VideoThumbnailPageState();
}

class _VideoThumbnailPageState extends State<VideoThumbnailPage> {
  Uint8List? _thumbnailBytes;

  @override
  void initState() {
    super.initState();
    _generateThumbnail();
  }

  Future<void> _generateThumbnail() async {
    final tempDir = await getTemporaryDirectory();
    final fileName = widget.videoPath.split('/').last;
    final tempFile = File('${tempDir.path}/$fileName');

    // Asset'tan geçici dosyaya kopyala
    final ByteData data = await rootBundle.load(widget.videoPath);
    final buffer = data.buffer.asUint8List();
    await tempFile.writeAsBytes(buffer);

    final uint8list = await VideoThumbnail.thumbnailData(
      video: tempFile.path,
      imageFormat: ImageFormat.PNG,
      maxWidth: 128,
      quality: 25,
    );

    setState(() {
      _thumbnailBytes = uint8list;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: _thumbnailBytes != null
            ? Image.memory(_thumbnailBytes!)
            : CircularProgressIndicator(),
      ),
    );
  }
}