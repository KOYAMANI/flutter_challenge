import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_challenge/domain/models/models.dart';

//TODO delete unused contructors
const lon = 113.2;
const lat = 23.1;
const uri =
    "https://www.7timer.info/bin/astro.php?lon=113.2&lat=23.1&ac=0&unit=metric&output=json";

//API URL = "https://www.7timer.info/bin/astro.php?lon=113.2&lat=23.1&ac=0&unit=metric&output=json"

// Future<WeatherData> getCurrentWeather(UserLocation location) async {
Future<List<WeatherData>> fetchWeather(UserLocation location) async {
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
