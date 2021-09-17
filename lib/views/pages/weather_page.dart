import 'package:flutter/material.dart';
import 'package:provider/provider.dart' as provider;
import 'package:flutter_challenge/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_challenge/domain/models/models.dart';
import 'package:flutter_challenge/domain/repositories/repositories.dart';
import 'package:flutter_challenge/helpers/helpers.dart';

//This is a page to show current City and Weather

class WeatherPage extends StatefulWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  bool isFetchingWeather = false;
  ScrollController _scrollController = ScrollController();
  TimeHelper timeHelper = TimeHelper();
  BoxDecoration customDecoration = const BoxDecoration(
    gradient: LinearGradient(
        begin: Alignment(0.5, -1.1),
        end: Alignment(1.0, 1.0),
        colors: [Colors.blueAccent, Colors.lightBlueAccent]),
  );

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var userLocation = provider.Provider.of<UserLocation>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Weather',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
      ),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.2, //0.15
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
                      return _buildBottomSheet(userLocation);
                    });
              }
            },
            child: Card(
              child: Container(
                decoration: customDecoration.copyWith(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ListTile(
                      leading:
                          const Icon(Icons.location_on, color: Colors.white),
                      title: Text(
                        'Location',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                    const Divider(
                      color: Colors.white,
                      height: 8,
                      thickness: 1,
                      indent: 10,
                      endIndent: 10,
                    ),
                    Text(
                      userLocation.city,
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    Text(
                      userLocation.country,
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    //TODO get and show tempeature data from API
                    Text(
                      '__°C',
                      style: Theme.of(context).textTheme.headline1,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

//Bottom sheet shows detailed forcast based on the user location
  _buildBottomSheet(UserLocation userLocation) {
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
                      icon: const Icon(
                        Icons.close,
                        color: Colors.white,
                      )),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.2),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              child: Consumer(builder: (context, watch, child) {
                final weather = watch(currentWeatherProvider(userLocation));

                return weather.when(
                  data: (weather) => Column(
                    children: [
                      Text(
                        userLocation.city,
                        style: Theme.of(context).textTheme.headline3,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 7,
                      ),
                      Expanded(
                        child: ListView.builder(
                            controller: _scrollController,
                            scrollDirection: Axis.horizontal,
                            itemCount: weather.length,
                            itemBuilder: (context, index) {
                              final data = weather[index];
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    // Text(data.timepoint.toString()),
                                    // Show weekday
                                    Text(
                                      timeHelper
                                          .getDayAndTime(data.timepoint)
                                          .weekday,
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                    // Show time in 24hour
                                    Text(
                                      timeHelper
                                          .getDayAndTime(data.timepoint)
                                          .hour
                                          .toString(),
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),

                                    Text(
                                      '${data.temp2m}°C',
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),

                                    Text(
                                      cloudCover['${data.cloudcover}']!,
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                    // Text(seeing['${data.seeing}']!),
                                    // Text(transparency['${data.transparency}']!),
                                    // Text(liftedIndex['${data.liftedIndex}']!),
                                    // Text(cloudCover['${data.cloudcover}']!),
                                    Text(
                                      rh2m['${data.rh2m}']!,
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                    // Text('precType: ${data.precType}'),
                                  ],
                                ),
                              );
                            }),
                      )
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
                          context.refresh(currentWeatherProvider(userLocation));
                        },
                        child: const Text('Try again'),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _refreshList(userLocation) async {
    try {
      context.refresh(currentWeatherProvider(userLocation));
    } catch (e) {
      print(e);
    }
  }
}
