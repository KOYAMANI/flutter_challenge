import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_challenge/views/bloc/blocs.dart';
import 'package:flutter_challenge/views/pages/pages.dart';
import 'package:flutter_challenge/services/location_service.dart';
import 'package:flutter_challenge/domain/models/models.dart';
import 'package:provider/provider.dart' as provider;

//This is a Navigation Screen
class NavigationScreen extends StatefulWidget {
  const NavigationScreen({Key? key}) : super(key: key);
  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<BottomNavBarBloc, BottomNavBarState>(
        builder: (BuildContext context, BottomNavBarState state) {
          if (state is PageLoading) {
            return const Scaffold(
              backgroundColor: Colors.black,
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (state is WeatherPageLoaded) {
            return provider.StreamProvider<UserLocation>(
              create: (_) => LocationService().getStreamData,
              initialData: UserLocation(
                  latitude: 0.00,
                  longtitude: 0.00,
                  country: 'Country failed to load',
                  city: 'City failed to load'),
              child: const WeatherPage(),
            );
          }
          if (state is CVPageLoaded) {
            return CVPage();
          }
          return Container();
        },
      ),
      bottomNavigationBar: BlocBuilder<BottomNavBarBloc, BottomNavBarState>(
        builder: (BuildContext context, BottomNavBarState state) {
          return Theme(
            data: Theme.of(context).copyWith(
              splashColor: Colors.white,
              canvasColor: Colors.white,
            ),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              unselectedIconTheme: const IconThemeData(
                size: 30,
                color: Colors.grey,
              ),
              selectedIconTheme: const IconThemeData(
                size: 34,
                color: Colors.blueAccent,
              ),
              currentIndex:
                  context.select((BottomNavBarBloc bloc) => bloc.currentIndex),
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.wb_sunny,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.person,
                  ),
                  label: '',
                ),
              ],
              onTap: (index) =>
                  context.read<BottomNavBarBloc>().add(PageTapped(index)),
            ),
          );
        },
      ),
    );
  }
}
