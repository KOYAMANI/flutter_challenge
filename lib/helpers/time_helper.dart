import 'package:flutter_challenge/domain/models/models.dart';
import 'package:flutter_challenge/domain/repositories/repositories.dart';

// To convert API response body ['timepoint'] to weather forcast calender
class TimeHelper {
  final now = DateTime.now();
  final hour = DateTime.now().hour;
  final month = DateTime.now().month;
  final date = DateTime.now().day;
  final String today = weekDays['${DateTime.now().weekday}']!;

  // TODO? should it get the time from coordinate data
  // id == API response.body['timepoint']
  DayAndTime getDayAndTime({required int id}) {
    int shownTime = hour;
    if (id != 3) {
      shownTime = hour + id - 3;
    }
    return getWeekDay(hour: shownTime);
  }

  DayAndTime getWeekDay({required int hour}) {
    int dateCode;
    int newHour = hour;
    if (hour <= 24) {
      dateCode = DateTime.now().weekday;
    } else if (hour <= 48) {
      newHour = hour - 24;
      dateCode = DateTime.now().weekday + 1;
      // dateCode must not be grater than 7
      if (dateCode > 7) {
        dateCode -= 7;
      }
    } else if (hour <= 72) {
      newHour = hour - 48;
      dateCode = DateTime.now().weekday + 2;
      if (dateCode > 7) {
        dateCode -= 7;
      }
    } else {
      newHour = hour - 72;
      dateCode = DateTime.now().weekday + 3;
      if (dateCode > 7) {
        dateCode -= 7;
      }
    }
    return DayAndTime(weekday: weekDays['$dateCode']!, hour: newHour);
  }
}
