// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();
    _fadeInText();
  }

//deneme sdsadassdenemeeee
  void _fadeInText() {
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _opacity = 1.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [
            SizedBox.expand(
              child: Image.asset(
                'assets/images/1.jpg',
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: screenHeight * 0.15,
              left: 0,
              right: 0,
              child: AnimatedOpacity(
                opacity: _opacity,
                duration: Duration(seconds: 2),
                child: Text(
                  'Hello',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: screenWidth * 0.07,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),
            Positioned(
              top: screenHeight * 0.23,
              left: 0,
              right: 0,
              child: AnimatedOpacity(
                opacity: _opacity,
                duration: Duration(seconds: 5),
                child: Text(
                  "Let's start relaxing",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: screenWidth * 0.07,
                      fontWeight: FontWeight.normal),
                ),
              ),
            ),
            Positioned(
              bottom: screenHeight * 0.1,
              left: screenWidth * 0.38,
              right: screenWidth * 0.38,
              child: AnimatedOpacity(
                  opacity: _opacity,
                  duration: Duration(seconds: 7),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      side: BorderSide(
                          color: Colors.white, width: screenWidth * 0.003),
                      shape: StadiumBorder(),
                    ),
                    onPressed: () {},
                    child: Text(
                      "Start",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: screenWidth * 0.05,
                          fontWeight: FontWeight.w300),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
