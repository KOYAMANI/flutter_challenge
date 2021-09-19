import 'package:equatable/equatable.dart';

// This is a data model for the forcast calender

class DayAndTime extends Equatable {
  final String weekday;
  final int hour;

  const DayAndTime({
    required this.weekday,
    required this.hour,
  });

  @override
  List<Object?> get props => [weekday, hour];
}
