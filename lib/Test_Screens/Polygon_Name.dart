import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Polyogn_Name_Screen extends StatefulWidget {
  const Polyogn_Name_Screen({Key? key}) : super(key: key);

  @override
  State<Polyogn_Name_Screen> createState() => _Polyogn_Name_ScreenState();
}

class _Polyogn_Name_ScreenState extends State<Polyogn_Name_Screen> {
  final List<LatLng> polygonCoordinates = [
    const LatLng(37.43296265331129, -122.08832357078792),
    const LatLng(37.43006265331129, -122.08832357078792),
    const LatLng(37.43006265331129, -122.08369334595644),
    const LatLng(37.43296265331129, -122.08369334595644),
  ];

  final Map<String, LatLng> polygonNames = {
    'Polygon 1': const LatLng(37.43296265331129, -122.08832357078792),
    'Polygon 2': const LatLng(37.43006265331129, -122.08832357078792),
    'Polygon 3': const LatLng(37.43006265331129, -122.08369334595644),
    'Polygon 4': const LatLng(37.43296265331129, -122.08369334595644),
  };

  Set<Marker> markers = {};

  @override
  void initState() {
    super.initState();
    getMarkers();
  }

  @override
  Widget build(BuildContext context) {
    Set<Polygon> polygons = {
      Polygon(
        polygonId: const PolygonId('polygon1'),
        points: polygonCoordinates,
        strokeColor: Colors.red,
        strokeWidth: 2,
        fillColor: Colors.blue.withOpacity(0.3),
      ),
    };

    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: LatLng(37.42796133580664, -122.085749655962),
          zoom: 15,
        ),
        polygons: polygons,
        markers: markers,
      ),
    );
  }

  Future<void> getMarkers() async {
    markers.clear();
    polygonNames.entries.forEach((entry) async {
      Marker m = Marker(
        markerId: MarkerId(entry.key),
        position: _calculatePolygonCentroid(entry.value),
        icon: await _getMarkerBitmap(205, text: entry.key),
        infoWindow: InfoWindow(title: entry.key),
      );
      markers.add(m);
      setState(() {});
    });
  }

  LatLng _calculatePolygonCentroid(LatLng polygon) {
    double latitudeSum = 0.0;
    double longitudeSum = 0.0;
    int pointCount = polygonCoordinates.length;

    for (var point in polygonCoordinates) {
      latitudeSum += point.latitude;
      longitudeSum += point.longitude;
    }

    return LatLng(
      latitudeSum / pointCount,
      longitudeSum / pointCount,
    );
  }

  Future<BitmapDescriptor> _getMarkerBitmap(int size, {String? text}) async {
    if (kIsWeb) size = (size / 2).floor();

    final PictureRecorder pictureRecorder = PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);
    final Paint paint1 = Paint()..color = Colors.blue;
    final Paint paint2 = Paint()..color = Colors.white;

    canvas.drawCircle(Offset(size / 2, size / 2), size / 2.0, paint1);
    canvas.drawCircle(Offset(size / 2, size / 2), size / 2.2, paint2);
    canvas.drawCircle(Offset(size / 2, size / 2), size / 2.8, paint1);

    if (text != null) {
      TextPainter painter = TextPainter(textDirection: TextDirection.ltr);
      painter.text = TextSpan(
        text: text,
        style: const TextStyle(
          fontSize: 10,
          color: Colors.white,
          fontWeight: FontWeight.normal,
        ),
      );
      painter.layout();
      painter.paint(
        canvas,
        Offset(size / 2 - painter.width / 2, size / 2 - painter.height / 2),
      );
    }

    final img = await pictureRecorder.endRecording().toImage(size, size);
    final data = await img.toByteData(format: ImageByteFormat.png) as ByteData;

    return BitmapDescriptor.fromBytes(data.buffer.asUint8List());
  }
}
