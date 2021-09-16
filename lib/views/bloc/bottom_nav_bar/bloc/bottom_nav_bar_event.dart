import 'package:equatable/equatable.dart';

abstract class BottomNavBarEvent extends Equatable {
  const BottomNavBarEvent();
}

class AppStarted extends BottomNavBarEvent {
  const AppStarted();

  @override
  List<Object> get props => [];

  @override
  String toString() => 'AppStarted';
}

class PageTapped extends BottomNavBarEvent {
  final int index;
  const PageTapped(this.index);

  @override
  List<Object> get props => [];

  @override
  String toString() => 'PageTapped: $index';
}
