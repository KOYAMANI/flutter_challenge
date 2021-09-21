import 'package:flutter/material.dart';
import 'package:flutter_challenge/views/widgets/weather_forecast.dart';
import 'package:provider/provider.dart' as provider;
import 'package:flutter_challenge/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_challenge/domain/models/models.dart';
import 'package:flutter_challenge/helpers/helpers.dart';
import 'package:weather_icons/weather_icons.dart';

//This is a page to show current City name and temperature

class WeatherPage extends StatefulWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  TimeHelper timeHelper = TimeHelper();
  WeatherIconHelper weatherIconHelper = WeatherIconHelper();

  bool isFetchingWeather = false;

  BoxDecoration customDecoration = const BoxDecoration(
    gradient: LinearGradient(
        begin: Alignment(0.5, -1.1),
        end: Alignment(1.0, 1.0),
        colors: [Colors.blueAccent, Colors.lightBlueAccent]),
  );

  @override
  Widget build(BuildContext context) {
    var userLocation = provider.Provider.of<UserLocation>(context);
    return Scaffold(
      backgroundColor: Colors.white60,
      appBar: AppBar(
        title: Text('Weather',
            style: Theme.of(context).appBarTheme.titleTextStyle),
      ),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.2,
          child: GestureDetector(
            onTap: () {
              setState(() {
                isFetchingWeather = true;
              });
              if (isFetchingWeather) {
                showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    builder: (BuildContext context) {
                      //Show detailed weather forecast with a bottom sheet
                      return WeatherForecast(userLocation: userLocation);
                    });
              }
            },
            child: Card(
              child: Container(
                decoration: customDecoration.copyWith(
                    borderRadius: BorderRadius.circular(8.0)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ListTile(
                        leading:
                            const Icon(Icons.location_on, color: Colors.white),
                        title: Text(userLocation.city,
                            style: Theme.of(context).textTheme.headline2)),
                    const Divider(
                        color: Colors.white,
                        height: 8,
                        thickness: 1,
                        indent: 10,
                        endIndent: 10),
                    const SizedBox(height: 10),
                    Consumer(builder: (context, watch, child) {
                      final weather = watch(weatherProvider(userLocation));

                      return weather.when(
                          data: (weather) => Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('${weather[0].temp2m}°C',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline3),
                                  const SizedBox(width: 5),
                                  BoxedIcon(
                                      weatherIconHelper.getWeatherIcon(
                                          data: weather[0]),
                                      size: 30),
                                ],
                              ),
                          loading: () => const CircularProgressIndicator(
                                backgroundColor: Colors.white,
                              ),
                          error: (error, _) => ListTile(
                              leading: IconButton(
                                icon: const Icon(Icons.refresh,
                                    color: Colors.white),
                                onPressed: () => context
                                    .refresh(weatherProvider(userLocation)),
                              ),
                              title: Text(error.toString(),
                                  style:
                                      Theme.of(context).textTheme.bodyText1)));
                    })
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
