import 'package:flutter/material.dart';
import 'package:flutter_challenge/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_challenge/domain/models/models.dart';
import 'package:flutter_challenge/helpers/helpers.dart';
import 'package:flutter_challenge/domain/repositories/repositories.dart';

class DetailedForecast extends StatefulWidget {
  final UserLocation userLocation;
  const DetailedForecast({Key? key, required this.userLocation})
      : super(key: key);

  @override
  State<DetailedForecast> createState() => _DetailedForecastState();
}

class _DetailedForecastState extends State<DetailedForecast> {
  TimeHelper timeHelper = TimeHelper();
  ScrollController _verticalScrollController = ScrollController();
  @override
  void initState() {
    _verticalScrollController = ScrollController();
    super.initState();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.33,
      child: Consumer(builder: (context, watch, child) {
        final weather = watch(weatherProvider(widget.userLocation));
        return weather.when(
          data: (weather) => Column(
            children: [
              const Divider(
                  color: Colors.white,
                  height: 8,
                  thickness: 1,
                  indent: 5,
                  endIndent: 5),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('day', style: Theme.of(context).textTheme.bodyText1),
                    Text('time', style: Theme.of(context).textTheme.bodyText1),
                    Text('cloud', style: Theme.of(context).textTheme.bodyText1),
                    Text('seeing',
                        style: Theme.of(context).textTheme.bodyText1),
                    Text('transp',
                        style: Theme.of(context).textTheme.bodyText1),
                    Text('wind', style: Theme.of(context).textTheme.bodyText1),
                    Text('humid', style: Theme.of(context).textTheme.bodyText1),
                  ],
                ),
              ),
              const Divider(
                  color: Colors.white,
                  height: 8,
                  thickness: 1,
                  indent: 5,
                  endIndent: 5),
              Expanded(
                child: Scrollbar(
                  controller: _verticalScrollController,
                  child: ListView.builder(
                      controller: _verticalScrollController,
                      itemCount: 9,
                      itemBuilder: (context, index) {
                        final data = weather[index];
                        return Padding(
                          padding:
                              const EdgeInsets.fromLTRB(8.0, 12.0, 8.0, 12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              //Shows only necessary datas for the user since API returns too many information
                              //Show weekday
                              Text(
                                  timeHelper
                                      .getDayAndTime(id: data.timepoint)
                                      .weekday,
                                  style: Theme.of(context).textTheme.bodyText1),
                              const SizedBox(width: 7),
                              if (index == 0)
                                Text('Now',
                                    style:
                                        Theme.of(context).textTheme.bodyText1),
                              if (index != 0)
                                Text(
                                    timeHelper
                                        .getDayAndTime(id: data.timepoint)
                                        .hour
                                        .toString(),
                                    style:
                                        Theme.of(context).textTheme.bodyText1),
                              const SizedBox(width: 7),
                              Text(cloudCover['${data.cloudcover}']!,
                                  style: Theme.of(context).textTheme.bodyText1),
                              const SizedBox(width: 7),
                              Text(seeing['${data.seeing}']!,
                                  style: Theme.of(context).textTheme.bodyText1),
                              const SizedBox(width: 7),
                              Text(transparency['${data.transparency}']!,
                                  style: Theme.of(context).textTheme.bodyText1),
                              const SizedBox(width: 7),
                              Text('${data.windData.speed}',
                                  style: Theme.of(context).textTheme.bodyText1),
                              const SizedBox(width: 7),
                              Text(
                                rh2m['${data.rh2m}']!,
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              const SizedBox(width: 7),
                            ],
                          ),
                        );
                      }),
                ),
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
                child: const Text('Reload'),
              ),
            ],
          ),
        );
      }),
    );
  }
}
