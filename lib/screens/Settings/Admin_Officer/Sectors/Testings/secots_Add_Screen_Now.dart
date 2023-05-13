import 'package:dengue_tracing_application/Global/Paths.dart';
import 'package:dengue_tracing_application/Global/Screen_Paths.dart';
import 'package:dengue_tracing_application/Global/Packages_Path.dart';
import 'package:http/http.dart' as http;

class PolygonCreator extends StatefulWidget {
  const PolygonCreator({super.key});

  @override
  _PolygonCreatorState createState() => _PolygonCreatorState();
}

class PolygonData {
  String secName;
  int threshold;
  String dessription;
  List<List<double>> points;

  PolygonData(
      {required this.secName,
      required this.threshold,
      required this.dessription,
      required this.points});

  Map<String, dynamic> toJson() {
    return {
      'secName': secName,
      'threshold': threshold,
      'description': dessription,
      'points': points,
    };
  }
}

class _PolygonCreatorState extends State<PolygonCreator> {
  final Set<Marker> _markers = {};
  Set<Polygon> _polygons = {};
  GoogleMapController? _controller;
  bool _showSavedPolygons = false;

  @override
  void initState() {
    super.initState();
    _loadSavedPolygons();
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller = controller;
  }

  void _onTap(LatLng point) {
    setState(() {
      _markers.add(Marker(
        markerId: MarkerId(_markers.length.toString()),
        position: point,
      ));
    });
  }

  void _onSavePressedapi() async {
    final polygonData = PolygonData(
      secName: 'Example Sector',
      threshold: 50,
      dessription: 'Example Description',
      points: _markers
          .map((m) => [m.position.latitude, m.position.longitude])
          .toList(),
    );

    final response = await http.post(
      Uri.parse('$ip/SavePolygons'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(polygonData.toJson()),
    );

    if (response.statusCode == 200) {
      // success
    } else {
      // error
    }

    // clear markers and set flag to true
    setState(() {
      _markers.clear();
      _showSavedPolygons = true;
    });
  }

  void _onSavePressed() async {
    final polygon = Polygon(
      polygonId: PolygonId(_polygons.length.toString()),
      points: _markers.map((m) => m.position).toList(),
      fillColor: Colors.blue.withOpacity(0.5),
      strokeColor: Colors.blue,
      strokeWidth: 2,
    );
    setState(() {
      _polygons.add(polygon);
      _markers.clear();
      _showSavedPolygons = true;
    });
    final polygonList = _polygons.toList();
    final jsonData = jsonEncode(
      polygonList.map((p) => p.toJson()).toList(),
    );
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('savedPolygons', jsonData);
    _onSavePressedapi();
  }

  void _loadSavedPolygons() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonData = prefs.getString('savedPolygons');
    if (jsonData != null) {
      final polygonDataList = jsonDecode(jsonData);
      final polygons = polygonDataList.map((pd) {
        final polygonId = PolygonId(pd['id'] ?? "");
        final points = List<LatLng>.from(
          pd['points'].map((p) => LatLng(p[0], p[1])),
        );
        final fillColor = Color(pd['fillColor']);
        final strokeColor = Color(pd['strokeColor']);
        final strokeWidth = pd['strokeWidth'];
        return Polygon(
          polygonId: polygonId,
          points: points,
          fillColor: fillColor,
          strokeColor: strokeColor,
          strokeWidth: strokeWidth,
        );
      }).toSet();
      setState(() {
        _polygons = polygons;
        _showSavedPolygons = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ScfColor,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Polygon Creator'),
          ),
          body: Stack(
            children: [
              GoogleMap(
                markers: _markers,
                polygons: _polygons,
                onMapCreated: _onMapCreated,
                onTap: _onTap,
                initialCameraPosition: const CameraPosition(
                  target: LatLng(33.643005, 73.077706),
                  zoom: 14.4746,
                ),
              ),
              if (_showSavedPolygons)
                SizedBox(
                  height: double.infinity,
                  width: double.infinity,
                  child: GoogleMap(
                    polygons: _polygons,
                    initialCameraPosition: const CameraPosition(
                      target: LatLng(33.643005, 73.077706),
                      zoom: 14.4746,
                    ),
                  ),
                ),
            ],
          ),
          floatingActionButton: Positioned(
            right: 40,
            bottom: 50,
            child: FloatingActionButton(
              onPressed: _onSavePressed,
              child: const Icon(Icons.save),
            ),
          ),
        ),
      ),
    );
  }
}
