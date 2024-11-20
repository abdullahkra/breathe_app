import 'package:flutter/material.dart';
import 'package:day_picker/day_picker.dart';

class SelectDaysWidget extends StatelessWidget {
  final List<DayInWeek> days;
  final Function(List<String>) onSelect;
  final double fontSize;
  final FontWeight fontWeight;
  final BoxDecoration boxDecoration;

  const SelectDaysWidget({
    super.key,
    required this.days,
    required this.onSelect,
    required this.fontSize,
    required this.fontWeight,
    required this.boxDecoration,
  });

  @override
  Widget build(BuildContext context) {
    return SelectWeekDays(
      fontSize: fontSize,
      fontWeight: fontWeight,
      days: days,
      border: true,
      boxDecoration: boxDecoration,
      onSelect: onSelect,
    );
  }
}
