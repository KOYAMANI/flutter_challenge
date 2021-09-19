import 'package:flutter/material.dart';
import 'package:flutter_challenge/domain/models/models.dart';
import 'package:flutter_challenge/helpers/helpers.dart';
import 'package:weather_icons/weather_icons.dart';

class WeatherIconHelper {
  TimeHelper timeHelper = TimeHelper();
  final sunny1 = WeatherIcons.day_sunny;

  IconData getWeatherIcon({required WeatherData data}) {
    print(data);
    final time = timeHelper.getDayAndTime(id: data.timepoint).hour;
    final dayNight = checkDayOrNight(time: time);
    print(dayNight);
    if (dayNight == 0) {
      if (data.precType == 'none') {
        if (data.cloudcover <= 3) {
          return WeatherIcons.day_sunny;
        } else if (data.cloudcover <= 9) {
          return WeatherIcons.day_cloudy;
        }
      } else if (data.precType == 'rain') {
        return WeatherIcons.day_rain;
      } else if (data.precType == 'snow') {
        return WeatherIcons.day_snow;
      } else {
        return Icons.error;
      }
    } else if (dayNight == 1) {
      if (data.precType == 'none') {
        if (data.cloudcover <= 3) {
          return WeatherIcons.night_clear;
        } else if (data.cloudcover <= 9) {
          return WeatherIcons.night_cloudy;
        }
      } else if (data.precType == 'rain') {
        return WeatherIcons.night_rain;
      } else if (data.precType == 'snw') {
        return WeatherIcons.night_snow;
      } else {
        return (Icons.error);
      }
    }
    return (Icons.error);
  }

  int checkDayOrNight({required int time}) {
    if (time > 24) {
      throw Exception('Error check day or night');
    } else if (time > 5 && time < 22) {
      return 0; //day
    } else {
      return 1; //night
    }
  }
}
