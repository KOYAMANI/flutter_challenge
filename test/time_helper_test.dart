import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_challenge/helpers/helpers.dart';
import 'package:flutter_challenge/domain/models/models.dart';
import 'package:flutter_challenge/domain/repositories/repositories.dart';

// This is the test for methods of the TimeHelper class
void main() {
  TimeHelper timeHelper = TimeHelper();
  var moonLanding = DateTime.parse("1993-11-14 12:00:00Z"); //Sunday
  group('getWeekDay', () {
    test('output current date and time when current time is passed', () {
      final result = timeHelper.getWeekDay(
        hour: DateTime.now().hour,
      );

      expect(
          result,
          DayAndTime(
            weekday: weekDays['${DateTime.now().weekday}']!,
            hour: DateTime.now().hour,
          ));
    });

    test(
        'output future date and time for tmr when future time (after 26 hrs) is passed',
        () {
      final result = timeHelper.getWeekDay(
        hour: moonLanding.hour + 24,
      );

      expect(
          result,
          DayAndTime(
            weekday: weekDays['1']!,
            hour: 12,
          ));
    });

    test(
        'output future date and time for the day after tmr when future time (after 48 hrs) is passed',
        () {
      final result = timeHelper.getWeekDay(
        hour: moonLanding.hour + 48,
      );

      expect(
          result,
          DayAndTime(
            weekday: weekDays['2']!,
            hour: 12,
          ));
    });

    test(
        'output date and time in 3 days when future time (after 72 hrs) is passed',
        () {
      final result = timeHelper.getWeekDay(
        hour: moonLanding.hour + 72,
      );

      expect(
          result,
          DayAndTime(
            weekday: weekDays['3']!,
            hour: 12,
          ));
    });
  });
  group('getDayAndTime', () {
    test('output current date and time when the id == 3 is passed', () {
      final result = timeHelper.getDayAndTime(id: 3);

      expect(
          result,
          DayAndTime(
            weekday: weekDays['${DateTime.now().weekday}']!,
            hour: DateTime.now().hour,
          ));
    });
  });
}
