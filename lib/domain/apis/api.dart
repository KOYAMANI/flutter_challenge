import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_challenge/domain/models/models.dart';

//TODO delete unused contructors
const lon = 113.2;
const lat = 23.1;
const uri =
    "https://www.7timer.info/bin/astro.php?lon=113.2&lat=23.1&ac=0&unit=metric&output=json";

//API URL = "https://www.7timer.info/bin/astro.php?lon=113.2&lat=23.1&ac=0&unit=metric&output=json"

//TODO delete unused function
Future<dynamic> fetchWeather() async {
  final url = Uri.parse(uri);
  final res = await http.get(url);

  if (res.statusCode == 200) {
    print(res.body);
    var data = jsonDecode(res.body)['dataseries'];
    return data;
  } else {
    throw Exception('couldn´t fetch Weather');
  }
}

//TODO delete unused function
Future<WeatherData> fetchTempreature(UserLocation location) async {
  final url = Uri.parse(
      "https://www.7timer.info/bin/astro.php?lon=${location.longtitude}&lat=${location.latitude}&ac=0&unit=metric&output=json");
  final res = await http.get(url);

  if (res.statusCode == 200) {
    var body = jsonDecode(res.body)['dataseries'];
    print(body);
    WeatherData weatherData = WeatherData(
        timepoint: body['timepoint'],
        cloudcover: body['cloudcover'],
        seeing: body['seeing'],
        transparency: body['tansparency'],
        liftedIndex: body['ifted_index'],
        rh2m: body['rh2m'],
        temp2m: body['temp2m'],
        precType: body['prec_type'],
        //TODO implement get windData
        windData: body['wind10m']);
    return weatherData;
  } else {
    throw Exception('couldn´t fetch Weather');
  }
}

// Future<WeatherData> getCurrentWeather(UserLocation location) async {
Future<List<WeatherData>> getCurrentWeather(UserLocation location) async {
  print('lon:${location.longtitude}');
  print('lat: ${location.latitude}');
  final url = Uri.parse(
      "https://www.7timer.info/bin/astro.php?lon=${location.longtitude}&lat=${location.latitude}&ac=0&unit=metric&output=json");

  final res = await http.get(url);

  if (res.statusCode == 200) {
    var jsonList = jsonDecode(res.body)['dataseries'] as List;
    return jsonList.map((e) => WeatherData.fromJson(e)).toList();
  } else {
    throw Exception('couldn´t fetch Weather');
  }
}
