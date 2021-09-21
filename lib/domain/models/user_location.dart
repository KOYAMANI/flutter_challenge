import 'package:equatable/equatable.dart';

//This is a data model for the user coordination
class UserLocation extends Equatable {
  final double latitude;
  final double longitude;
  final String country;
  final String city;

  const UserLocation(
      {required this.latitude,
      required this.longitude,
      required this.country,
      required this.city});
  @override
  List<Object?> get props => [latitude, longitude, country, city];
}
