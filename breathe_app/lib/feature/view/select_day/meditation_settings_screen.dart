// lib/screens/meditation_settings_screen.dart
import 'package:breathe_app/core/init/meditation_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MeditationSettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MeditationProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(' Choose your meditate time'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              provider.meditationTime != null
                  ? 'Meditation Time: ${provider.meditationTime!.format(context)}'
                  : 'No meditation time set',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                TimeOfDay? newTime = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (newTime != null) {
                  provider.setMeditationTime(newTime);
                }
              },
              child: Text('Set Meditation Time'),
            ),
            ElevatedButton(
              onPressed: (
                  //buraya bir sonraki syfa eklenecek
                  ) async {},
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
