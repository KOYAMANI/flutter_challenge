import 'package:equatable/equatable.dart';

abstract class BottomNavBarState extends Equatable {
  const BottomNavBarState();
}

class CurrentIndexChanged extends BottomNavBarState {
  final int currentIndex;

  const CurrentIndexChanged(this.currentIndex);

  @override
  List<Object> get props => [currentIndex];

  @override
  String toString() => 'CurrentIndexChanged to $currentIndex';
}

class PageLoading extends BottomNavBarState {
  const PageLoading();

  @override
  List<Object> get props => [];

  @override
  String toString() => 'PageLoading';
}

class WeatherPageLoaded extends BottomNavBarState {
  const WeatherPageLoaded();
  @override
  List<Object> get props => [];
}

class CVPageLoaded extends BottomNavBarState {
  const CVPageLoaded();

  @override
  List<Object> get props => [];
}
