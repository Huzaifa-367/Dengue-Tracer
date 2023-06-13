import 'dart:async';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../Global/Packages_Path.dart';
import '../Global/constant.dart';
import '../screens/Map/Models/Places.dart';

class ClusterMap extends StatefulWidget {
  const ClusterMap({super.key});

  @override
  State<ClusterMap> createState() => ClusterMapState();
}

class ClusterMapState extends State<ClusterMap> {
  late ClusterManager _manager;

  final Completer<GoogleMapController> _controller = Completer();

  Set<Marker> markers = {};

  final CameraPosition _parisCameraPosition =
      const CameraPosition(target: LatLng(33.643005, 73.077706), zoom: 12.0);

  List<Place> items = [];

  @override
  void initState() {
    _manager = _initClusterManager();
    super.initState();
    _getDengueUsers();
  }

  Future<void> _getDengueUsers() async {
    try {
      // final String apiUrl = '$api/GetDengueUsersSameSector?sec_id=$secId';
      final response =
          await http.get(Uri.parse('$api/GetDengueUsersSameSectorOfficer'));

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        items.clear();
        for (var element in data) {
          items.add(Place(
              stationId: element['user_id'].toString(),
              latLng: LatLng(
                double.parse(element['home_location'].split(',')[0]),
                double.parse(element['home_location'].split(',')[1]),
              )));
        }
      } else {
        throw Exception('Failed to fetch dengue users.');
      }
    } catch (e) {
      //
    }
    setState(() {});
  }

  ClusterManager _initClusterManager() {
    return ClusterManager<Place>(items, _updateMarkers,
        markerBuilder: _markerBuilder);
  }

  void _updateMarkers(Set<Marker> markers) {
    print('Updated ${markers.length} markers');
    setState(() {
      this.markers = markers;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: _parisCameraPosition,
          markers: markers,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
            _manager.setMapId(controller.mapId);
          },
          onCameraMove: _manager.onCameraMove,
          onCameraIdle: _manager.updateMap),
    );
  }

  Future<Marker> Function(Cluster<Place>) get _markerBuilder =>
      (cluster) async {
        return Marker(
          markerId: MarkerId(cluster.getId()),
          position: cluster.location,
          onTap: () {
            print('---- $cluster');
            for (var p in cluster.items) {
              print(p);
            }
          },
          icon: await _getMarkerBitmap(cluster.isMultiple ? 125 : 75,
              text: cluster.isMultiple ? cluster.count.toString() : null),
        );
      };

  Future<BitmapDescriptor> _getMarkerBitmap(int size, {String? text}) async {
    if (kIsWeb) size = (size / 2).floor();

    final PictureRecorder pictureRecorder = PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);
    final Paint paint1 = Paint()..color = btnColor;
    final Paint paint2 = Paint()..color = Colors.white;

    canvas.drawCircle(Offset(size / 2, size / 2), size / 2.0, paint1);
    canvas.drawCircle(Offset(size / 2, size / 2), size / 2.2, paint2);
    canvas.drawCircle(Offset(size / 2, size / 2), size / 2.8, paint1);

    if (text != null) {
      TextPainter painter = TextPainter(textDirection: TextDirection.ltr);
      painter.text = TextSpan(
        text: text,
        style: TextStyle(
            fontSize: size / 3,
            color: Colors.white,
            fontWeight: FontWeight.normal),
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
