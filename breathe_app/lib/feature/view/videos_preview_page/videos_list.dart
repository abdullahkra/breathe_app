import 'package:flutter/material.dart';

void main() {
  runApp(VideosPage());
}

class VideosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Önizleme Kartları'),
        ),
        body: PreviewGrid(),
      ),
    );
  }
}

class PreviewGrid extends StatelessWidget {
  final List<Map<String, dynamic>> items = [
    {
      'image': 'https://example.com/image1.jpg',
      'title': 'Chistovodnaya River, Primorsky Krai',
      'label': 'Free',
      //'page': PageOne(), // Bu kart PageOne sayfasına yönlendirir
    },
    {
      'image': 'https://example.com/image2.jpg',
      'title': 'Petrov Island, Primorsky Krai',
      'label': 'PRO',
      //'page': PageTwo(), // Bu kart PageTwo sayfasına yönlendirir
    },
    {
      'image': 'https://example.com/image3.jpg',
      'title': 'Petrov Island, Primorsky Krai',
      'label': 'Free',
      //'page': PageThree(), // Bu kart PageThree sayfasına yönlendirir
    },
    {
      'image': 'https://example.com/image4.jpg',
      'title': 'Cape of Four Cliffs, Primorsky Krai',
      'label': 'PRO',
      //'page': PageFour(), // Bu kart PageFour sayfasına yönlendirir
    },
    // Daha fazla öğe ekleyin
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // İki sütunlu bir grid
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
        childAspectRatio: 0.7, // Kartların boyut oranı
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return PreviewCard(
          image: items[index]['image']!,
          title: items[index]['title']!,
          label: items[index]['label']!,
          page: items[index]['page']!,
        );
      },
    );
  }
}

class PreviewCard extends StatelessWidget {
  final String image;
  final String title;
  final String label;
  final Widget page;

  PreviewCard({
    required this.image,
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
              child: Image.network(
                image,
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
