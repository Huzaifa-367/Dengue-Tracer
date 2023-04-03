import 'dart:convert';

import 'package:dengue_tracing_application/Global/constant.dart';
import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart' as loc;

getDengueUsers() async {
  var response = await Dio().get('$ip/GetDengueUsers');

  if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(response.data);

    markers = data.map((item) {
      final LatLng latLng = LatLng(item['lat_long'][0], item['lat_long'][1]);
      final String title = item['name'];
      final String snippet = item['email'];

      return Marker(
        markerId: MarkerId(title),
        position: latLng,
        infoWindow: InfoWindow(
          title: title,
          snippet: snippet,
        ),
      );
    }).toList();
  } else {
    throw Exception('Failed to fetch dengue users.');
  }
}

class Sector {
  final int sec_id;
  final String sec_name;
  final double threshold;
  final String description;
  final List<LatLng> latLongs;

  Sector({
    required this.sec_id,
    required this.sec_name,
    required this.threshold,
    required this.description,
    required this.latLongs,
  });

  factory Sector.fromJson(Map<String, dynamic> json) {
    return Sector(
      sec_id: json['sec_id'],
      sec_name: json['sec_name'],
      threshold: json['threshold'],
      description: json['description'],
      latLongs: List<LatLng>.from(
        json['latLongs'].map((latLng) => LatLng(latLng[0], latLng[1])),
      ),
    );
  }
}

Future<Position> getGeoLocationPosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    await Geolocator.openLocationSettings();
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
}

GoogleMapController? mapController;
loc.Location _location = loc.Location();

Future<void> getUserLocation() async {
  try {
    // Request location permissions if not already granted
    bool serviceEnabled;
    loc.PermissionStatus permissionGranted;
    serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }
    permissionGranted = await _location.hasPermission();
    if (permissionGranted == loc.PermissionStatus.denied) {
      permissionGranted = await _location.requestPermission();
      if (permissionGranted != loc.PermissionStatus.granted) {
        return;
      }
    }

    // Get the user's current location
    loc.LocationData locationData = await _location.getLocation();
    LatLng userLocation =
        LatLng(locationData.latitude!, locationData.longitude!);

    // Move the map to the user's current location
    mapController!.animateCamera(CameraUpdate.newLatLng(userLocation));
  } catch (e) {
    print(e);
  }
}
