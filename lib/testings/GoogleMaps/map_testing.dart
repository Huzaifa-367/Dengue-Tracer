import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _mapController;
  LatLng? _currentLocation;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  void _getCurrentLocation() async {
    Location location = Location();
    LocationData locationData = await location.getLocation();
    setState(() {
      _currentLocation =
          LatLng(locationData.latitude!, locationData.longitude!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: _currentLocation ?? const LatLng(37.4219999, -122.0840575),
          zoom: 14.0,
        ),
        myLocationEnabled: true,
        onMapCreated: (GoogleMapController controller) {
          _mapController = controller;
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          LocationData locationData = await Location().getLocation();
          LatLng currentLocation =
              LatLng(locationData.latitude!, locationData.longitude!);
          _mapController!.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(
              target: currentLocation,
              zoom: 14.0,
            ),
          ));
        },
        child: const Icon(Icons.my_location),
      ),
    );
  }
}
