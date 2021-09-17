//This is a data model for the user coordination
class UserLocation {
  final double latitude;
  final double longtitude;
  final String country;
  final String city;

  UserLocation(
      {required this.latitude,
      required this.longtitude,
      required this.country,
      required this.city});
}
