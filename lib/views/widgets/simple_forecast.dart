import 'package:flutter/material.dart';
import 'package:flutter_challenge/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_challenge/domain/models/models.dart';
import 'package:flutter_challenge/helpers/helpers.dart';

class SimpleForecast extends StatefulWidget {
  final UserLocation userLocation;
  const SimpleForecast({Key? key, required this.userLocation})
      : super(key: key);

  @override
  State<SimpleForecast> createState() => _SimpleForecastState();
}

class _SimpleForecastState extends State<SimpleForecast> {
  TimeHelper timeHelper = TimeHelper();
  WeatherIconHelper weatherIconHelper = WeatherIconHelper();
  ScrollController _horizontalScrollController = ScrollController();

  @override
  void initState() {
    _horizontalScrollController = ScrollController();
    super.initState();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.30,
      child: Consumer(builder: (context, watch, child) {
        final weather = watch(weatherProvider(widget.userLocation));
        return weather.when(
          data: (weather) => Column(
            children: [
              Text(widget.userLocation.city,
                  style: Theme.of(context).textTheme.headline3),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Text('${weather[0].temp2m}°C',
                  style: Theme.of(context).textTheme.headline3),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Expanded(
                child: ListView.builder(
                    controller: _horizontalScrollController,
                    scrollDirection: Axis.horizontal,
                    itemCount: weather.length,
                    itemBuilder: (context, index) {
                      final data = weather[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            if (index == 0)
                              Text('Now',
                                  style: Theme.of(context).textTheme.bodyText1),
                            if (index != 0)
                              Text(
                                  timeHelper
                                      .getDayAndTime(id: data.timepoint)
                                      .hour
                                      .toString(),
                                  style: Theme.of(context).textTheme.bodyText1),
                            Icon(weatherIconHelper.getWeatherIcon(data: data)),
                            Text('${data.temp2m}°C',
                                style: Theme.of(context).textTheme.bodyText1)
                          ],
                        ),
                      );
                    }),
              ),
            ],
          ),
          loading: () => const Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.yellow,
            ),
          ),
          error: (error, _) => Column(
            children: [
              Text(error.toString()),
              ElevatedButton(
                  onPressed: () {
                    context.refresh(weatherProvider(widget.userLocation));
                  },
                  child: const Text('Reload')),
            ],
          ),
        );
      }),
    );
  }
}
