import 'package:flutter_challenge/domain/models/models.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_challenge/helpers/helpers.dart';
import 'package:weather_icons/weather_icons.dart';

// This is the test for methods of the TimeHelper class
void main() {
  WeatherIconHelper helper = WeatherIconHelper();

  group('getWeatherIcon', () {
    test('get weather icon', () {
      final WindData windData = WindData(direction: 'S', speed: 10);
      final result = helper.getWeatherIcon(
          data: WeatherData(
              timepoint: 3,
              cloudcover: 3,
              seeing: 3,
              transparency: 3,
              liftedIndex: 2,
              rh2m: 2,
              temp2m: 2,
              precType: 'none',
              windData: windData));

      expect(result, WeatherIcons.day_sunny);
    });
  });
  group('checkDayOrNight', () {
    //day: 6-20, night: 23-5
    test('output day if daytime : 1', () {
      final result = helper.checkDayOrNight(time: 6);

      expect(result, 0);
    });
    test('output day if daytime : 2', () {
      final result = helper.checkDayOrNight(time: 20);

      expect(result, 0);
    });
    test('output night if night time : 1', () {
      final result = helper.checkDayOrNight(time: 23);

      expect(result, 1);
    });
    test('output night if night time : 2', () {
      final result = helper.checkDayOrNight(time: 4);

      expect(result, 1);
    });
  });
}
