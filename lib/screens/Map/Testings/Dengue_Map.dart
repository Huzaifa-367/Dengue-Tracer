import 'dart:convert';

import 'package:dengue_tracing_application/Global/constant.dart';
import 'package:dengue_tracing_application/Global/Widgets/GetDialogue_tester.dart';
import 'package:dengue_tracing_application/Global/Widgets/text_widget.dart';
import 'package:custom_info_window/custom_info_window.dart';

import 'package:dengue_tracing_application/Global/Widgets/textfield_Round_readonly.dart';
import 'package:dengue_tracing_application/model/MAP/Map_API.dart';
import 'package:dengue_tracing_application/model/MAP/map_style.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:map_picker/map_picker.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import 'package:http/http.dart' as http;

import 'package:intl/intl.dart';
import 'package:dio/dio.dart';

class CasesMap extends StatefulWidget {
  const CasesMap({Key? key}) : super(key: key);

  @override
  _CasesMapState createState() => _CasesMapState();
}

final CustomInfoWindowController _customInfoWindowController =
    CustomInfoWindowController();
void dispose() {
  _customInfoWindowController.dispose();
}

class _CasesMapState extends State<CasesMap> {
  @override
  void initState() {
    super.initState();
    getGeoLocationPosition();
    _getDengueUsers();
    _fetchPolygons();
    // loadDengueCases();
  }

  final List<dynamic> _mapThemes = [
    {
      'name': 'Standard',
      'style': MapStyle().standard,
      'image':
          'https://maps.googleapis.com/maps/api/staticmap?center=-33.9775,151.036&zoom=13&format=png&maptype=roadmap&style=element:labels%7Cvisibility:off&style=feature:administrative.land_parcel%7Cvisibility:off&style=feature:administrative.neighborhood%7Cvisibility:off&size=164x132&key=AIzaSyDk4C4EBWgjuL1eBnJlu1J80WytEtSIags&scale=2'
    },
    {
      'name': 'Night',
      'style': MapStyle().night,
      'image':
          'https://maps.googleapis.com/maps/api/staticmap?center=-33.9775,151.036&zoom=13&format=png&maptype=roadmap&style=element:geometry%7Ccolor:0x242f3e&style=element:labels%7Cvisibility:off&style=element:labels.text.fill%7Ccolor:0x746855&style=element:labels.text.stroke%7Ccolor:0x242f3e&style=feature:administrative.land_parcel%7Cvisibility:off&style=feature:administrative.locality%7Celement:labels.text.fill%7Ccolor:0xd59563&style=feature:administrative.neighborhood%7Cvisibility:off&style=feature:poi%7Celement:labels.text.fill%7Ccolor:0xd59563&style=feature:poi.park%7Celement:geometry%7Ccolor:0x263c3f&style=feature:poi.park%7Celement:labels.text.fill%7Ccolor:0x6b9a76&style=feature:road%7Celement:geometry%7Ccolor:0x38414e&style=feature:road%7Celement:geometry.stroke%7Ccolor:0x212a37&style=feature:road%7Celement:labels.text.fill%7Ccolor:0x9ca5b3&style=feature:road.highway%7Celement:geometry%7Ccolor:0x746855&style=feature:road.highway%7Celement:geometry.stroke%7Ccolor:0x1f2835&style=feature:road.highway%7Celement:labels.text.fill%7Ccolor:0xf3d19c&style=feature:transit%7Celement:geometry%7Ccolor:0x2f3948&style=feature:transit.station%7Celement:labels.text.fill%7Ccolor:0xd59563&style=feature:water%7Celement:geometry%7Ccolor:0x17263c&style=feature:water%7Celement:labels.text.fill%7Ccolor:0x515c6d&style=feature:water%7Celement:labels.text.stroke%7Ccolor:0x17263c&size=164x132&key=AIzaSyDk4C4EBWgjuL1eBnJlu1J80WytEtSIags&scale=2'
    },
    {
      'name': 'Aubergine',
      'style': MapStyle().aubergine,
      'image':
          'https://maps.googleapis.com/maps/api/staticmap?center=-33.9775,151.036&zoom=13&format=png&maptype=roadmap&style=element:geometry%7Ccolor:0x1d2c4d&style=element:labels%7Cvisibility:off&style=element:labels.text.fill%7Ccolor:0x8ec3b9&style=element:labels.text.stroke%7Ccolor:0x1a3646&style=feature:administrative.country%7Celement:geometry.stroke%7Ccolor:0x4b6878&style=feature:administrative.land_parcel%7Cvisibility:off&style=feature:administrative.land_parcel%7Celement:labels.text.fill%7Ccolor:0x64779e&style=feature:administrative.neighborhood%7Cvisibility:off&style=feature:administrative.province%7Celement:geometry.stroke%7Ccolor:0x4b6878&style=feature:landscape.man_made%7Celement:geometry.stroke%7Ccolor:0x334e87&style=feature:landscape.natural%7Celement:geometry%7Ccolor:0x023e58&style=feature:poi%7Celement:geometry%7Ccolor:0x283d6a&style=feature:poi%7Celement:labels.text.fill%7Ccolor:0x6f9ba5&style=feature:poi%7Celement:labels.text.stroke%7Ccolor:0x1d2c4d&style=feature:poi.park%7Celement:geometry.fill%7Ccolor:0x023e58&style=feature:poi.park%7Celement:labels.text.fill%7Ccolor:0x3C7680&style=feature:road%7Celement:geometry%7Ccolor:0x304a7d&style=feature:road%7Celement:labels.text.fill%7Ccolor:0x98a5be&style=feature:road%7Celement:labels.text.stroke%7Ccolor:0x1d2c4d&style=feature:road.highway%7Celement:geometry%7Ccolor:0x2c6675&style=feature:road.highway%7Celement:geometry.stroke%7Ccolor:0x255763&style=feature:road.highway%7Celement:labels.text.fill%7Ccolor:0xb0d5ce&style=feature:road.highway%7Celement:labels.text.stroke%7Ccolor:0x023e58&style=feature:transit%7Celement:labels.text.fill%7Ccolor:0x98a5be&style=feature:transit%7Celement:labels.text.stroke%7Ccolor:0x1d2c4d&style=feature:transit.line%7Celement:geometry.fill%7Ccolor:0x283d6a&style=feature:transit.station%7Celement:geometry%7Ccolor:0x3a4762&style=feature:water%7Celement:geometry%7Ccolor:0x0e1626&style=feature:water%7Celement:labels.text.fill%7Ccolor:0x4e6d70&size=164x132&key=AIzaSyDk4C4EBWgjuL1eBnJlu1J80WytEtSIags&scale=2'
    }
  ];

  //
  final _controller = Completer<GoogleMapController>();
  //
  GoogleMapController? _control;
  //
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
  //

  MapPickerController mapPickerController = MapPickerController();
  //
  CameraPosition cameraPosition = const CameraPosition(
    target: LatLng(33.643005, 73.077706),
    zoom: 14.4746,
  );
  //
//
  var addressController = TextEditingController();
  //

  List<dynamic> _users = [];
  Set<Marker> _markers = {};

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

  double _currentSliderValue = 1.0;
  String? selectedDate;
  Future<void> _getDengueCasesByDate(int daysToSubtract) async {
    final apiUrl = '$ip/GetDengueUsersByDate?daysToSubtract=$daysToSubtract';
    final response = await http.get(Uri.parse(apiUrl));

    final now = DateTime.now();
    final date = now.subtract(Duration(days: daysToSubtract));
    selectedDate = DateFormat('yyyy-MM-dd').format(date);

    if (response.statusCode == 200) {
      setState(() {
        _users = json.decode(response.body);
        _markers = Set<Marker>.from(_users.map((user) => Marker(
              markerId: MarkerId(user['name']),
              position: LatLng(
                double.parse(user['home_location'].split(',')[0]),
                double.parse(user['home_location'].split(',')[1]),
              ),
              infoWindow: InfoWindow(title: user['name']),
              // icon: BitmapDescriptor.defaultMarkerWithHue(
              //     BitmapDescriptor.hueRed),
            )));
      });
    } else {
      throw Exception('Failed to fetch dengue cases.');
    }
  }

  final Set<Polygon> _polygons = {};
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
                getDialogue(context, "$secName\n$threshold");
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
                //add map picker controller
                mapPickerController: mapPickerController,
                child: GoogleMap(
                  //indoorViewEnabled: true,
                  //liteModeEnabled: true,
                  buildingsEnabled: true,
                  //zoomGesturesEnabled: true,
                  myLocationEnabled: true,
                  zoomControlsEnabled: false,
                  // hide location button
                  myLocationButtonEnabled: true,

                  // mapToolbarEnabled: true,
                  //trafficEnabled: true,
                  mapType: MapType.normal,
                  //  camera position
                  initialCameraPosition: cameraPosition,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                    _control = controller;
                    _customInfoWindowController.googleMapController =
                        controller;
                  },
                  markers: _markers,
                  polygons: _polygons,

                  onCameraMoveStarted: () {
                    // notify map is moving
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

              //My Address Field
              Positioned(
                top: MediaQuery.of(context).viewPadding.top + 10,
                width: MediaQuery.of(context).size.width - 70,
                height: 150,
                left: 10,
                child: MyTextField_ReadOnly(
                  maxlines: 1,
                  readonly: true,
                  controller: addressController,
                  hintText: "Location",

                  sufixIconPress: () {
                    addressController.text =
                        "${cameraPosition.target.latitude}, ${cameraPosition.target.longitude}";
                  },
                  //prefixIcon: const Icon(Icons.map),
                  sufixIcon: Icons.arrow_forward_rounded,
                ),
              ),

              CustomInfoWindow(
                controller: _customInfoWindowController,
                height: MediaQuery.of(context).size.height * 0.35,
                width: MediaQuery.of(context).size.width * 0.8,
                offset: 60.0,
              ),

              //Theme Selection Button
              Positioned(
                bottom: 80,
                right: 30,
                child: Container(
                  width: 35,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: btnColor,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      MaterialButton(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) => Container(
                                padding: const EdgeInsets.all(20),
                                color: ScfColor,
                                height:
                                    MediaQuery.of(context).size.height * 0.3,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Select Theme",
                                      style: TextStyle(
                                          color: txtColor,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    SizedBox(
                                      width: double.infinity,
                                      height: 100,
                                      child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: _mapThemes.length,
                                          itemBuilder: (context, index) {
                                            return GestureDetector(
                                              onTap: () {
                                                _control!.setMapStyle(
                                                  _mapThemes[index]['style'],
                                                );
                                                Navigator.pop(context);
                                              },
                                              child: Container(
                                                width: 100,
                                                margin: const EdgeInsets.only(
                                                    right: 10),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: NetworkImage(
                                                          _mapThemes[index]
                                                              ['image']),
                                                    )),
                                              ),
                                            );
                                          }),
                                    ),
                                  ],
                                )),
                          );
                        },
                        padding: const EdgeInsets.all(0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          Icons.layers_rounded,
                          size: 25,
                          color: ScfColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              //Zoom Selection Button
              Positioned(
                bottom: 30,
                left: 15,
                child: Container(
                    width: 35,
                    height: 105,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: btnColor,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        MaterialButton(
                          onPressed: () {
                            _control!.animateCamera(CameraUpdate.zoomIn());
                          },
                          padding: const EdgeInsets.all(0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            Icons.add,
                            size: 25,
                            color: ScfColor,
                          ),
                        ),
                        const Divider(height: 5),
                        MaterialButton(
                          onPressed: () {
                            _control!.animateCamera(CameraUpdate.zoomOut());
                          },
                          padding: const EdgeInsets.all(0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            Icons.remove,
                            size: 25,
                            color: ScfColor,
                          ),
                        )
                      ],
                    )),
              ),

              //Slider
              Positioned(
                bottom: -5,
                left: 60,
                child: Row(
                  //mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 30,
                              width: 55,
                              decoration: BoxDecoration(
                                color: btnColor,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextWidget(
                                    title: "DAY 1",
                                    txtSize: 10,
                                    txtColor: ScfColor),
                              ),
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            Container(
                              height: 30,
                              width: 80,
                              decoration: BoxDecoration(
                                color: btnColor,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextWidget(
                                    title: selectedDate != null
                                        ? "$selectedDate"
                                        : "Select A Day",
                                    txtSize: 10,
                                    txtColor: ScfColor),
                              ),
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            Container(
                              height: 30,
                              width: 55,
                              decoration: BoxDecoration(
                                color: btnColor,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextWidget(
                                    title: "DAY 30",
                                    txtSize: 10,
                                    txtColor: ScfColor),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 305,
                          child: Slider(
                            activeColor: btnColor,
                            value: _currentSliderValue,
                            min: 1,
                            max: 30,
                            divisions: 30,
                            label: _currentSliderValue.round().toString(),
                            onChanged: (double value) {
                              setState(() {
                                _currentSliderValue = value;
                                _getDengueCasesByDate(
                                    _currentSliderValue.toInt());
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              //User Current Location
              // Positioned(
              //   bottom: 95,
              //   right: 15,
              //   child: Container(
              //     width: 35,
              //     //height: 105,
              //     decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(10),
              //       color: btnColor,
              //     ),
              //     child: MaterialButton(
              //       onPressed: (() {
              //         // _control?.getLatLng(
              //         //     const ScreenCoordinate(x: 12.211212, y: 12, 2111));
              //       }),
              //       padding: const EdgeInsets.all(0),
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(10),
              //       ),
              //       child: const Icon(Icons.my_location, size: 25),
              //     ),
              //   ),
              // ),
              // Display latitude & longtitude
            ],
          ),
        ),
      ),
    );
  }
}
