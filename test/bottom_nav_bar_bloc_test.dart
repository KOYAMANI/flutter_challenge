import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_challenge/views/bloc/blocs.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_challenge/domain/repositories/repositories.dart';
import 'package:mockito/mockito.dart';

//This is the tests file for bottom_nav_bar bloc
class MockCVPageRepository extends Mock implements CVPageRepository {}

void main() {
  MockCVPageRepository mockCVPageRepository;
  group('App Started', () {
    mockCVPageRepository = MockCVPageRepository();
    BottomNavBarBloc? bottomNavBarBloc =
        BottomNavBarBloc(cvPageRepository: mockCVPageRepository);

    setUp(() {
      bottomNavBarBloc =
          BottomNavBarBloc(cvPageRepository: mockCVPageRepository);
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
