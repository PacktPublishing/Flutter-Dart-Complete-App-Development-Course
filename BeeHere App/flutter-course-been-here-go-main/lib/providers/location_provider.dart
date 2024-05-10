import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationProvider extends ChangeNotifier {
  Future<LocationData?> getCurrentLocation() async {
    Location location = Location();

    bool serviceEnabled;

    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();

    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return null;
      }
    }

    // Check if location permissions are granted
    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }
    // Fetch the user's current location
    try {
      locationData = await location.getLocation();
      return locationData;
    } catch (e) {
      // Failed to fetch location, handle accordingly
      print('Failed to get location $e');
      return null;
    }
  }
}
