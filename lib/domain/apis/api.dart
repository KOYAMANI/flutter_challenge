import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_challenge/domain/models/models.dart';

final lon = 113.2;
final lat = 23.1;
final uri =
    "https://www.7timer.info/bin/astro.php?lon=113.2&lat=23.1&ac=0&unit=metric&output=json";

// Future<List<WeatherData>> fetchWeather() async {
//   final url = Uri.parse(uri);
//   final res = await http.get(url);

//   if (res.statusCode == 200) {
//     var jsonList = jsonDecode(res.body) as List;
//     return jsonList.map((e) => WeatherData.fromJson(e)).toList();
//   } else {
//     throw Exception('couldn´t fetch Weather');
//   }
// }

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

// Future<WeatherData> getCurrentWeather(UserLocation location) async {
Future<List<WeatherData>> getCurrentWeather(UserLocation location) async {
  //TODO Pass geolocation and Time data to get specific weather data from the list

  print('lon:${location.longtitude}');
  print('lat: ${location.latitude}');
  final url = Uri.parse(
      "https://www.7timer.info/bin/astro.php?lon=${location.longtitude}&lat=${location.latitude}&ac=0&unit=metric&output=json");

  final res = await http.get(url);

  if (res.statusCode == 200) {
    var body = jsonDecode(res.body)['dataseries'];
    // WeatherData weatherData = WeatherData(
    //   timepoint: body['timepoint'],
    //   cloudcover: body['cloudcover'],
    //   seeing: body['seeing'],
    //   transparency: body['tansparency'],
    //   liftedIndex: body['ifted_index'],
    //   rh2m: body['rh2m'],
    //   temp2m: body['temp2m'],
    //   precType: body['prec_type'],
    // );
    // return weatherData;
    var jsonList = jsonDecode(res.body)['dataseries'] as List;
    return jsonList.map((e) => WeatherData.fromJson(e)).toList();
  } else {
    throw Exception('couldn´t fetch Weather');
  }
}

//Example
// Future<dynamic> setAudioDevices(int id) async {
//   // JSON response example
//   // { "success": true }
//   final url = Uri.parse('http://127.0.0.1:5000/api/setAudioDevice?id=$id');
//   final res = await http.get(url);

//   if (res.statusCode == 200) {
//     return jsonDecode(res.body)['success'];
//   } else {
//     throw Exception('can´t set audio device');
//   }
// }