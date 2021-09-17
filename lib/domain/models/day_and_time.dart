import 'dart:ffi';

// This is a data model for the forcast calender
class DayAndTime {
  final String weekday;
  final int hour;

  const DayAndTime({
    required this.weekday,
    required this.hour,
  });
}
