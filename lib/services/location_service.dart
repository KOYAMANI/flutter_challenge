import 'dart:async';

import 'package:location/location.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:flutter_challenge/domain/models/models.dart';

class LocationService {
  //Keep track of current location
  Location location = Location();
  late UserLocation currentLocation;
  late geo.Placemark currentAddress;
  // late String currentAddress;

  //Continuously emit location updates
  final StreamController<UserLocation> _locationController =
      StreamController<UserLocation>.broadcast();

  Stream<UserLocation> get getStreamData => _locationController.stream;

  LocationService() {
    location.requestPermission().then((premission) {
      if (premission == PermissionStatus.granted) {
        location.onLocationChanged.listen((locationData) async {
          currentAddress = await getAddressFromLatLng(
              locationData.latitude!, locationData.longitude!);

          _locationController.add(UserLocation(
              latitude: locationData.latitude!,
              longtitude: locationData.longitude!,
              country: currentAddress.country!,
              city: currentAddress.locality!));
        });
      }
    });
  }

  Future<UserLocation> getLocation() async {
    try {
      var userLocation = await location.getLocation();
      currentAddress = await getAddressFromLatLng(
          userLocation.latitude!, userLocation.longitude!);

      currentLocation = UserLocation(
          latitude: userLocation.latitude!,
          longtitude: userLocation.longitude!,
          country: currentAddress.country!,
          city: currentAddress.locality!);
    } catch (e) {
      print('Could not get the location $e');
    }
    return currentLocation;
  }

  Future<geo.Placemark> getAddressFromLatLng(
      double? latitude, double? longitude) async {
    try {
      List<geo.Placemark> p =
          await geo.placemarkFromCoordinates(latitude!, longitude!);
      geo.Placemark place = p[0];
      currentAddress = place;
    } catch (e) {
      print(e);
    }
    return currentAddress;
  }
}
