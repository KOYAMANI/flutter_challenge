import 'models.dart';

//This is a data model for weather data from the API
//https://www.7timer.info/bin/api.pl?lon=14.398&lat=47.911&product=astro&output=json

class WeatherData {
  final int timepoint;
  final int cloudcover;
  final int seeing;
  final int transparency;
  final int liftedIndex;
  final int rh2m;
  final int temp2m;
  final String precType;
  WeatherData({
    required this.timepoint,
    required this.cloudcover,
    required this.seeing,
    required this.transparency,
    required this.liftedIndex,
    required this.rh2m,
    required this.temp2m,
    required this.precType,
  });

  factory WeatherData.fromJson(Map data) {
    return WeatherData(
      timepoint: data['timepoint'],
      cloudcover: data['cloudcover'],
      seeing: data['seeing'],
      transparency: data['transparency'],
      liftedIndex: data['lifted_index'],
      rh2m: data['rh2m'],
      temp2m: data['temp2m'],
      precType: data['prec_type'],
    );
  }
}
