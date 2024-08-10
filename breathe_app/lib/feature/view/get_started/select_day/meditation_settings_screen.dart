import 'package:breathe_app/core/init/meditation_provider.dart';
import 'package:breathe_app/feature/widget/day_selection_chip.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MeditationSettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MeditationProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Meditation Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'What time would you like to meditate?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ElevatedButton(
              onPressed: () async {
                TimeOfDay? pickedTime = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (pickedTime != null) {
                  provider.setMeditationTime(pickedTime);
                }
              },
              child: Text('Select Time'),
            ),
            SizedBox(height: 16),
            Text(
              'Which day would you like to meditate?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Wrap(
              spacing: 8.0,
              children: provider.days
                  .map((day) => DaySelectionChip(day: day))
                  .toList(),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                provider.saveSettings();
                provider.scheduleNotifications();
              },
              child: Text('Save'),
            ),
            TextButton(
              onPressed: () {
                // Navigate to the next screen if there is one
              },
              child: Text('No Thanks'),
            ),
          ],
        ),
      ),
    );
  }
}
