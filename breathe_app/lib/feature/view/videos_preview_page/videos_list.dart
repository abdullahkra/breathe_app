import 'dart:io';
import 'package:breathe_app/feature/view/settings_page/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:path_provider/path_provider.dart';
import 'package:breathe_app/feature/view/videos_preview_page/video_page.dart';

class VideosListPage extends StatefulWidget {
  const VideosListPage({super.key});

  @override
  State<VideosListPage> createState() => _VideosListPageState();
}

class _VideosListPageState extends State<VideosListPage> {
  List<Map<String, dynamic>> items = [];

  @override
  void initState() {
    super.initState();
    _generateThumbnails(); // Thumbnail'ları oluştur ve listeye ekle
  }

  Future<void> _generateThumbnails() async {
    final tempDir = await getTemporaryDirectory();
    final screenWidth = MediaQuery.of(context).size.width;

    final videos = [
      {
        'videoUrl': 'assets/videos/video1.mp4',
        'title': 'Waterfall',
        'label': 'Free',
      },
      {
        'videoUrl': 'assets/videos/forest1.mp4',
        'title': 'Forest',
        'label': 'PRO',
      },
      {
        'videoUrl': 'assets/videos/lake1.mp4',
        'title': 'Lake',
        'label': 'Free',
      },
      {
        'videoUrl': 'assets/videos/seawave1.mp4',
        'title': 'Sea',
        'label': 'Free',
      },
    ];

    for (var video in videos) {
      final videoUrl = video['videoUrl'] ?? '';
      final fileName = videoUrl.split('/').last;
      final tempFile = File('${tempDir.path}/$fileName');

      // Asset'ten geçici dosyaya kopyala
      final ByteData data = await rootBundle.load(videoUrl);
      final buffer = data.buffer.asUint8List();
      await tempFile.writeAsBytes(buffer);

      try {
        final thumbnailBytes = await VideoThumbnail.thumbnailData(
          video: tempFile.path,
          imageFormat: ImageFormat.PNG,
          maxWidth:
              (screenWidth * 1).toInt(), // Ekran genişliğine göre ayarlama
          quality: 100, // Kaliteyi artırdık
        );

        if (thumbnailBytes == null) {
          print('Thumbnail oluşturulamadi: $videoUrl');
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
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Breathe with Nature'),
        actions: [
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsPage()),
              );
            },
          ),
        ],
      ),
      body: items.isEmpty
          ? Center(
              child:
                  CircularProgressIndicator(), // Thumbnail'lar oluşturulurken gösterilecek
            )
          : GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // İki sütunlu bir grid
                crossAxisSpacing: screenWidth * 0.04,
                mainAxisSpacing: screenHeight * 0.03,
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

  const PreviewCard({
    super.key,
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
                    shadows: const [
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
