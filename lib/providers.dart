import 'package:flutter_challenge/domain/apis/api.dart';
import 'package:flutter_challenge/domain/models/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';

final weatherProvider = FutureProvider((ref) => fetchWeather());
final currentWeatherProvider = FutureProvider.family(
    (ref, UserLocation location) => getCurrentWeather(location));
