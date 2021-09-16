import 'package:flutter/material.dart';
import 'package:flutter_challenge/domain/models/models.dart';
import 'package:provider/provider.dart' as provider;
import 'package:flutter_challenge/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  bool isFetchingWeather = false;
  ScrollController _scrollController = ScrollController();

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
          height: MediaQuery.of(context).size.height * 0.15,
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
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  gradient: const LinearGradient(
                      begin: Alignment(0.5, -1.1),
                      end: Alignment(1.0, 1.0),
                      colors: [Colors.blueAccent, Colors.lightBlueAccent]),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ListTile(
                      leading: Icon(Icons.location_on, color: Colors.white),
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
                    // Text('latitude: ${userLocation.latitude}'),
                    // Text('longtitude: ${userLocation.longtitude}'),
                    Text(
                      userLocation.address,
                      style: Theme.of(context).textTheme.headline1,
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

  _buildBottomSheet(UserLocation userLocation) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.close)),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.4,
            child: Consumer(builder: (context, watch, child) {
              final data = watch(currentWeatherProvider(userLocation));
              return data.when(
                data: (data) => Column(
                  children: [
                    Text(userLocation.address),
                    Expanded(
                        child: RefreshIndicator(
                      onRefresh: () => _refreshList(userLocation),
                      child: ListView.builder(
                          controller: _scrollController,
                          scrollDirection: Axis.horizontal,
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            final weather = data[index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.blueAccent,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  children: [
                                    Text(weather.timepoint.toString()),
                                    Text('cloudcover: ${weather.cloudcover}'),
                                    Text('seeing: ${weather.seeing}'),
                                    Text(
                                        'transparency: ${weather.transparency}'),
                                    Text('liftedIndex: ${weather.liftedIndex}'),
                                    Text('rh2m: ${weather.rh2m}'),
                                    Text('tempreature: ${weather.temp2m}'),
                                    Text('precType: ${weather.precType}'),
                                  ],
                                ),
                              ),
                            );
                          }),
                    ))
                  ],
                ),
                loading: () => const Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.blue,
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
