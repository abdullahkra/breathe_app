import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SizedBox.expand(
          child: Image.asset(
            "assets/images/1.jpg",
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
