import 'package:dengue_tracing_application/Global/GetDialogue_tester.dart';
import 'package:dengue_tracing_application/Global/constant.dart';

//'$ip/getsectors'
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PolygonViewer extends StatefulWidget {
  const PolygonViewer({Key? key}) : super(key: key);

  @override
  _PolygonViewerState createState() => _PolygonViewerState();
}

class _PolygonViewerState extends State<PolygonViewer> {
  late final GoogleMapController _mapController;
  final Set<Polygon> _polygons = {};

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  Future<void> _fetchPolygons() async {
    try {
      final response = await Dio().get('$ip/getsectors');
      //final body = response.data;
      final body = response.data;
      if (body is List<dynamic>) {
        final data = body.map((item) => item as Map<String, dynamic>).toList();
        // Now you can access the properties of each item in the list
        for (final item in data) {
          final secId = item['sec_id'] as int;
          final secName = item['sec_name'] as String;
          final threshold = item['threshold'] as int;
          final description = item['description'] as String;
          final latLongs = item['latLongs'] as List<dynamic>;

          var latLngs = (item['latLongs'] as List<dynamic>)
              .map((e) => LatLng(
                    double.parse(e.split(',')[0]),
                    double.parse(e.split(',')[1]),
                  ))
              .toList();
          if (latLngs.isNotEmpty) {
            final polygon = Polygon(
              visible: true,
              consumeTapEvents: true,
              onTap: () {
                getDialogue(context, secName);
              },
              polygonId: PolygonId(secId.toString()),
              points: latLngs,
              strokeColor: Colors.blue,
              strokeWidth: 3,
              fillColor: Colors.blue.withOpacity(0.2),
            );
            setState(() {
              _polygons.add(polygon);
            });
          }
        }
      }
    } catch (error) {
      print('Failed to fetch polygons: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Polygon Viewer'),
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: const CameraPosition(
          target: LatLng(33.643005, 73.077706),
          zoom: 14.4746,
        ),
        polygons: _polygons,
        onMapCreated: (GoogleMapController controller) {
          _mapController = controller;
          _fetchPolygons();
        },
      ),
    );
  }
}
