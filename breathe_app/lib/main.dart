import 'package:breathe_app/core/init/meditation_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'feature/view/landing_page/landing_page.dart';

void main() {
  runApp(MeditationApp());
}

class MeditationApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MeditationProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LandingPage(), // LandingPage ana sayfa olarak ayarlandı
      ),
    );
  }
}
