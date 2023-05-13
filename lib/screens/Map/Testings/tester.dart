import 'package:dengue_tracing_application/Global/Paths.dart';
import 'package:dengue_tracing_application/Global/Packages_Path.dart';
import 'package:dengue_tracing_application/Global/Screen_Paths.dart';

import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:dengue_tracing_application/model/MAP/Map_API.dart';

class DengueMap extends StatefulWidget {
  const DengueMap({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _DengueMapState createState() => _DengueMapState();
}

final CustomInfoWindowController _customInfoWindowController =
    CustomInfoWindowController();
void dispose() {
  _customInfoWindowController.dispose();
}

class _DengueMapState extends State<DengueMap> {
  @override
  void initState() {
    super.initState();
    _tooltip = TooltipBehavior(enable: true);
    getGeoLocationPosition();
    _getDengueUsers();
    _getChartData();
    // loadDengueCases();
  }

  Set<Marker> _markers = {};
  List<_ChartData> _chartData = [];
  List<dynamic> _users = [];
  late TooltipBehavior _tooltip;

  Future<void> _getChartData() async {
    // Fetch data from API and parse into _ChartData list
    var response = await http.get(Uri.parse('$ip/GetDengueCasesByDate'));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      _chartData = List<_ChartData>.from(
        data.map(
          (x) => _ChartData(
            DateTime.parse(x['Date'].replaceAll('/', '-')),
            x['Count'],
          ),
        ),
      );
      //_createMarkers();
      setState(() {});
    }
  }

  final _controller = Completer<GoogleMapController>();
  //
  GoogleMapController? _control;
  //
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;

  MapPickerController mapPickerController = MapPickerController();
  //
  CameraPosition cameraPosition = const CameraPosition(
    target: LatLng(33.643005, 73.077706),
    zoom: 14.4746,
  );

  var addressController = TextEditingController();

  //Api to get all dengue users
  Future<void> _getDengueUsers() async {
    final String apiUrl = '$ip/GetDengueUsers';
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      setState(() {
        _users = json.decode(response.body);
        _markers = Set<Marker>.from(
          _users.map(
            (user) => Marker(
              markerId: MarkerId(user['name']),
              position: LatLng(
                double.parse(user['home_location'].split(',')[0]),
                double.parse(user['home_location'].split(',')[1]),
              ),
              infoWindow: InfoWindow(title: user['name']),
              icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueRed),
            ),
          ),
        );
      });
    } else {
      throw Exception('Failed to fetch dengue users.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ScfColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: ScfColor,
          body: Stack(
            alignment: Alignment.topCenter,
            children: [
              MapPicker(
                showDot: true,
                // pass icon widget
                iconWidget: Image.asset(
                  "assets/images/pin.png",
                  height: 52,
                  width: 42,
                ),

                mapPickerController: mapPickerController,
                child: GoogleMap(
                  buildingsEnabled: true,
                  myLocationEnabled: true,
                  zoomControlsEnabled: false,
                  myLocationButtonEnabled: true,
                  mapType: MapType.normal,
                  initialCameraPosition: cameraPosition,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                    _control = controller;
                    _customInfoWindowController.googleMapController =
                        controller;
                  },
                  markers: _markers,
                  onCameraMoveStarted: () {
                    mapPickerController.mapMoving!();
                    addressController.text = "checking ...";
                  },
                  onCameraMove: (cameraPosition) {
                    this.cameraPosition = cameraPosition;
                    _customInfoWindowController.onCameraMove!();
                    // _customInfoWindowController.onCameraMove!();
                  },
                  onCameraIdle: () async {
                    // notify map stopped moving
                    mapPickerController.mapFinishedMoving!();
                    //get address name from camera position
                    List<Placemark> placemarks = await placemarkFromCoordinates(
                      cameraPosition.target.latitude,
                      cameraPosition.target.longitude,
                    );

                    // update the ui with the address
                    addressController.text =
                        '${placemarks.first.name},${placemarks.first.subLocality}, ${placemarks.first.locality}, ${placemarks.first.country}';
                    //'${placemarks.first.name}, ${placemarks.first.postalCode}, ${placemarks.first.subLocality}, ${placemarks.first.locality}, ${placemarks.first.administrativeArea}, ${placemarks.first.country}';
                  },
                ),
              ),
              Positioned(
                top: 55,
                left: 16,
                right: 16,
                child: Container(
                  color: btnColor.withOpacity(.5),
                  alignment: Alignment.bottomCenter,
                  //padding: const EdgeInsets.only(bottom: 16.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 150.0,
                    child: SfCartesianChart(
                      zoomPanBehavior: ZoomPanBehavior(
                        enablePanning: true,
                      ),
                      primaryXAxis: DateTimeAxis(
                        autoScrollingMode: AutoScrollingMode.start,
                        //visibleMaximum: 5,
                        interval: 1,
                      ),
                      primaryYAxis: NumericAxis(
                        interval: 1,
                      ),
                      tooltipBehavior: _tooltip,
                      series: <ChartSeries>[
                        LineSeries<_ChartData, DateTime>(
                          dataSource: _chartData,
                          xValueMapper: (_ChartData data, _) => data.date,
                          yValueMapper: (_ChartData data, _) => data.cases,
                          name: 'Dengue Cases',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ChartData {
  _ChartData(this.date, this.cases);

  final DateTime date;
  final int cases;

  double get latitude => // Get latitude based on date
      // Example: latitude increases as the year progresses
      1.0 + (date.year - 2022) * 0.1;

  double get longitude => // Get longitude based on date
      // Example: longitude increases as the month progresses
      -1.0 - date.month * 0.1;
}
