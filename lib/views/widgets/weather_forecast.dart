import 'package:flutter/material.dart';
import 'package:flutter_challenge/views/widgets/widgets.dart';
import 'package:flutter_challenge/domain/models/models.dart';
import 'package:flutter_challenge/helpers/helpers.dart';

//This is a widget to show detailed forcast based on the current user location

class WeatherForecast extends StatefulWidget {
  final UserLocation userLocation;
  const WeatherForecast({Key? key, required this.userLocation})
      : super(key: key);

  @override
  State<WeatherForecast> createState() => _WeatherForecastState();
}

class _WeatherForecastState extends State<WeatherForecast> {
  TimeHelper timeHelper = TimeHelper();
  WeatherIconHelper weatherIconHelper = WeatherIconHelper();

  BoxDecoration customDecoration = const BoxDecoration(
    gradient: LinearGradient(
        begin: Alignment(0.5, -1.1),
        end: Alignment(1.0, 1.0),
        colors: [Colors.blueAccent, Colors.lightBlueAccent]),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: customDecoration,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                ListTile(
                  trailing: IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.close, color: Colors.white)),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.15),
              ],
            ),
            SimpleForecast(userLocation: widget.userLocation),
            DetailedForecast(userLocation: widget.userLocation)
          ],
        ),
      ),
    );
  }
}
