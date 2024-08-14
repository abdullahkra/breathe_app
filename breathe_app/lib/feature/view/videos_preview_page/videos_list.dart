import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:path_provider/path_provider.dart';
import 'package:breathe_app/feature/view/videos_preview_page/video_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> items = [];

  @override
  void initState() {
    super.initState();
    _generateThumbnails(); // Thumbnail'ları oluştur ve listeye ekle
  }

  Future<void> _generateThumbnails() async {
    final tempDir = await getTemporaryDirectory();

    final videos = [
      {
        'videoUrl': 'assets/videos/video1.mp4',
        'title': 'Chistovodnaya River, Primorsky Krai',
        'label': 'Free',
      },
      {
        'videoUrl': 'assets/videos/video1.mp4',
        'title': 'Petrov Island, Primorsky Krai',
        'label': 'PRO',
      },
    ];

    for (var video in videos) {
      final videoUrl = video['videoUrl'] as String? ?? '';
      final fileName = videoUrl.split('/').last;
      final tempFile = File('${tempDir.path}/$fileName');

      // Asset'tan geçici dosyaya kopyala
      final ByteData data = await rootBundle.load(videoUrl);
      final buffer = data.buffer.asUint8List();
      await tempFile.writeAsBytes(buffer);

      try {
        final thumbnailBytes = await VideoThumbnail.thumbnailData(
          video: tempFile.path, // Geçici dosya yolunu kullan
          imageFormat: ImageFormat.PNG,
          maxWidth: 128,
          quality: 75,
        );

        if (thumbnailBytes == null) {
          print('Thumbnail oluşturulamadı: $videoUrl');
        }

        setState(() {
          items.add({
            'image': thumbnailBytes!,
            'title': video['title'],
            'label': video['label'],
            'page': VideoPage(
              videoUrl: video['videoUrl']!,
              title: video['title']!,
            ),
          });
        });
      } catch (e) {
        print('Hata: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Breathe with Nature'),
      ),
      body: items.isEmpty
          ? Center(
              child:
                  CircularProgressIndicator(), // Thumbnail'lar oluşturulurken gösterilecek
            )
          : GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // İki sütunlu bir grid
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 0.7, // Kartların boyut oranı
              ),
              itemCount: items.length,
              itemBuilder: (context, index) {
                return PreviewCard(
                  imageBytes: items[index]['image']!,
                  title: items[index]['title']!,
                  label: items[index]['label']!,
                  page: items[index]['page']!,
                );
              },
            ),
    );
  }
}

class PreviewCard extends StatelessWidget {
  final Uint8List imageBytes;
  final String title;
  final String label;
  final Widget page;

  PreviewCard({
    required this.imageBytes,
    required this.title,
    required this.label,
    required this.page,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Image.memory(
                imageBytes,
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                margin: EdgeInsets.all(8.0),
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                decoration: BoxDecoration(
                  color: label == 'Free' ? Colors.blue : Colors.orange,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  label,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                margin: EdgeInsets.all(8.0),
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        offset: Offset(0.0, 0.0),
                        blurRadius: 6.0,
                        color: Colors.black54,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
