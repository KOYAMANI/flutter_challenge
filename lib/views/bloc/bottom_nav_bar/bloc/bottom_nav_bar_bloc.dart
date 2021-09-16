import 'dart:async';

import 'package:bloc/bloc.dart';
import 'bottom_nav_bar_event.dart';
import 'bottom_nav_bar_state.dart';

class BottomNavBarBloc extends Bloc<BottomNavBarEvent, BottomNavBarState> {
  BottomNavBarBloc() : super(const PageLoading());

  int currentIndex = 0;

  @override
  Stream<BottomNavBarState> mapEventToState(BottomNavBarEvent event) async* {
    if (event is AppStarted) {
      add(PageTapped(currentIndex));
    }
    if (event is PageTapped) {
      currentIndex = event.index;
      yield CurrentIndexChanged(currentIndex);
      yield const PageLoading();

      switch (currentIndex) {
        case 0:
          {
            yield const WeatherPageLoaded();
          }
          break;
        case 1:
          {
            yield const CVPageLoaded();
          }
          break;
      }
    }
  }
}
