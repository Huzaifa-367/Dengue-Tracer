import 'dart:async';
import 'package:dengue_tracing_application/Global/constant.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:dio/dio.dart';

class PolygonSaver extends StatefulWidget {
  const PolygonSaver({super.key});

  @override
  _PolygonSaverState createState() => _PolygonSaverState();
}

class _PolygonSaverState extends State<PolygonSaver> {
  final Completer<GoogleMapController> _controller = Completer();
  final Set<Polygon> _polygons = {};
  final List<LatLng> _currentPolygon = [];
  bool _isDrawing = false;

  void _toggleDrawing() {
    setState(() {
      _isDrawing = !_isDrawing;
    });
  }

  void _addPoint(LatLng point) {
    setState(() {
      _currentPolygon.add(point);
    });
  }

  void _updatePolygons() {
    final Polygon newPolygon = Polygon(
      polygonId: PolygonId(_currentPolygon.toString()),
      points: _currentPolygon,
      strokeColor: Colors.blue,
      strokeWidth: 3,
      fillColor: Colors.blue.withOpacity(0.2),
    );
    setState(() {
      _polygons.add(newPolygon);
      // _currentPolygon.clear();
    });
  }

  Future<void> _savePolygons(Set<Polygon> polygons) async {
    // Extract the necessary data from the polygons
    final List<List<List<double>>> latLongs = polygons.map((polygon) {
      final List<LatLng> points = polygon.points;
      return points.map((point) => [point.latitude, point.longitude]).toList();
    }).toList();

    // Create the request body as a JSON object
    final Map<String, dynamic> requestBody = {
      'secName': 'Sector 2',
      'threshold': 50.0,
      'description': 'Example Description',
      'latLongs': latLongs
    };

    // Send the HTTP request
    try {
      final Response response =
          await Dio().post('$ip/SavePolygons', data: requestBody);

      // Check if the request was successful
      if (response.statusCode == 200) {
        // Handle the success response
        print('Polygons saved successfully: ${response.data}');
        //snackBar(context, 'Polygons saved successfully');
      } else {
        // Handle the error response
        print('Failed to save polygons: ${response.data}');
      }
    } catch (error) {
      // Handle any errors that occur during the request
      print('Failed to save polygons: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Polygon Saver'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () => _savePolygons(_polygons),
          ),
        ],
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: const CameraPosition(
          target: LatLng(33.643005, 73.077706),
          zoom: 14.4746,
        ),
        polygons: _polygons,
        onTap: (LatLng point) {
          if (_isDrawing) {
            _addPoint(point);
            _updatePolygons();
          }
        },
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _toggleDrawing,
        child: Icon(_isDrawing ? Icons.stop : Icons.play_arrow),
      ),
    );
  }
}
