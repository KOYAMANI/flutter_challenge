import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_challenge/views/bloc/blocs.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('App Started', () {
    BottomNavBarBloc? bottomNavBarBloc;

    setUp(() {
      bottomNavBarBloc = BottomNavBarBloc();
    });
    blocTest<BottomNavBarBloc, BottomNavBarState>(
        'emits [] when nothing is added',
        build: () => bottomNavBarBloc!,
        expect: () => []);
    blocTest<BottomNavBarBloc, BottomNavBarState>(
        'emits [CurrentIndexChanged(0),PageLoading(),WeatherPageLoaded()] when AppStarted() is added',
        build: () => bottomNavBarBloc!,
        act: (bloc) => bloc.add(const AppStarted()),
        expect: () => [
              const CurrentIndexChanged(0),
              const PageLoading(),
              const WeatherPageLoaded()
            ]);
    blocTest<BottomNavBarBloc, BottomNavBarState>(
        'emits [CurrentIndexChanged(0),PageLoading(),WeatherPageLoaded()] when PageTapped(0) is added',
        build: () => bottomNavBarBloc!,
        act: (bloc) => bloc.add(const PageTapped(0)),
        expect: () => [
              const CurrentIndexChanged(0),
              const PageLoading(),
              const WeatherPageLoaded()
            ]);
    blocTest<BottomNavBarBloc, BottomNavBarState>(
        'emits [CurrentIndexChanged(1),PageLoading(),CVPageLoaded()] when PageTapped(1) is added',
        build: () => bottomNavBarBloc!,
        act: (bloc) => bloc.add(const PageTapped(1)),
        expect: () => [
              const CurrentIndexChanged(1),
              const PageLoading(),
              const CVPageLoaded()
            ]);
  });
}

// add(PageTapped(index)
