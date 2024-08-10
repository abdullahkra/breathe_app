import 'package:flutter/material.dart';

class DaySelectionChip extends StatelessWidget {
  final String day;

  const DaySelectionChip({required this.day});

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(day),
      selected: false, // Manage selected state appropriately
      onSelected: (selected) {
        // Handle chip selection
      },
    );
  }
}
