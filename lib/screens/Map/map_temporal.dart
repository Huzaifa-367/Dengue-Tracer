import 'dart:convert';
import 'package:dengue_tracing_application/Global/constant.dart';
import 'package:dengue_tracing_application/Global/textfield_Round_readonly.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:dengue_tracing_application/Global/text_widget.dart';
import 'package:custom_info_window/custom_info_window.dart';

import 'package:dengue_tracing_application/model/MAP/Map_API.dart';
import 'package:dengue_tracing_application/model/MAP/map_style.dart';
import 'dart:async';
import 'package:map_picker/map_picker.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

class DengueMap extends StatefulWidget {
  const DengueMap({Key? key}) : super(key: key);

  @override
  _DengueMapState createState() => _DengueMapState();
}

final CustomInfoWindowController _customInfoWindowController =
    CustomInfoWindowController();
void dispose() {
  _customInfoWindowController.dispose();
}

class _ChartData {
  _ChartData(this.date, this.cases);

  final String date;
  final int cases;
}

class _DengueMapState extends State<DengueMap> {
  @override
  void initState() {
    super.initState();
    _tooltip = TooltipBehavior(enable: true);
    getGeoLocationPosition();
    _getDengueUsers();
    _getChartData();
    _fetchPolygons();
    // loadDengueCases();
  }

  Set<Marker> _markers = {};
  final List<_ChartData> _chartData = [];
  List<dynamic> _users = [];
  late TooltipBehavior _tooltip;

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

  void _getChartData() async {
    var response = await http.get(Uri.parse('$ip/GetDengueCasesByDate'));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      for (var item in data) {
        // Trimming the time part from the date
        var trimmedDate = item['Date'].toString().split('T')[0];

        _chartData.add(_ChartData(trimmedDate, item['Count']));
      }
      setState(() {});
    }
  }

  // void _createMarkers() {
  //   _markers.clear();
  //   for (var data in _chartData) {
  //     var marker = Marker(
  //       markerId: MarkerId(data.date.toString()),
  //       position: LatLng(data.latitude, data.longitude),
  //       infoWindow: InfoWindow(title: 'Dengue Cases: ${data.cases}'),
  //       icon:
  //           BitmapDescriptor.defaultMarkerWithHue(_getMarkerColor(data.cases)),
  //     );
  //     _markers.add(marker);
  //   }
  // }

  // double _getMarkerColor(int cases) {
  //   // Define a color scheme based on the number of cases
  //   if (cases <= 10) {
  //     return BitmapDescriptor.hueGreen;
  //   } else if (cases <= 20) {
  //     return BitmapDescriptor.hueYellow;
  //   } else {
  //     return BitmapDescriptor.hueRed;
  //   }
  // }

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

  // List<dynamic> _users = [];
  // Set<Marker> _markers = {};

  //Api to get all dengue users
  // Future<void> _getDengueUsers() async {
  //   final String apiUrl = '$ip/GetDengueUsers';
  //   final response = await http.get(Uri.parse(apiUrl));

  //   if (response.statusCode == 200) {
  //     setState(() {
  //       _users = json.decode(response.body);
  //       _markers = Set<Marker>.from(
  //         _users.map(
  //           (user) => Marker(
  //             markerId: MarkerId(user['name']),
  //             position: LatLng(
  //               double.parse(user['home_location'].split(',')[0]),
  //               double.parse(user['home_location'].split(',')[1]),
  //             ),
  //             infoWindow: InfoWindow(title: user['name']),
  //             icon: BitmapDescriptor.defaultMarkerWithHue(
  //                 BitmapDescriptor.hueRed),
  //           ),
  //         ),
  //       );
  //     });
  //   } else {
  //     throw Exception('Failed to fetch dengue users.');
  //   }
  // }
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
              icon: user['user_id'] == loggedInUser!.user_id
                  ? BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueAzure)
                  : BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueRed),
              // flat: true,
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
  // Future<void> _fetchPolygons() async {
  //   try {
  //     final response = await Dio().get('$ip/getsectors');
  //     //final body = response.data;
  //     final body = response.data;
  //     if (body is List<dynamic>) {
  //       final data = body.map((item) => item as Map<String, dynamic>).toList();
  //       // Now you can access the properties of each item in the list
  //       for (final item in data) {
  //         final secId = item['sec_id'] as int;
  //         final secName = item['sec_name'] as String;
  //         final threshold = item['threshold'] as int;
  //         final description = item['description'] as String;
  //         final latLongs = item['latLongs'] as List<dynamic>;

  //         var latLngs = (item['latLongs'] as List<dynamic>)
  //             .map((e) => LatLng(
  //                   double.parse(e.split(',')[0]),
  //                   double.parse(e.split(',')[1]),
  //                 ))
  //             .toList();
  //         if (latLngs.isNotEmpty) {
  //           final polygon = Polygon(
  //             visible: true,
  //             consumeTapEvents: true,
  //             onTap: () {
  //               getDialogue(context, "$secName\n$threshold");
  //             },
  //             polygonId: PolygonId(secId.toString()),
  //             points: latLngs,
  //             strokeColor: Colors.blue,
  //             strokeWidth: 3,
  //             fillColor: Colors.blue.withOpacity(0.2),
  //           );
  //           setState(() {
  //             _polygons.add(polygon);
  //           });
  //         }
  //       }
  //     }
  //   } catch (error) {
  //     print('Failed to fetch polygons: $error');
  //   }
  // }

  // Future<void> _fetchPolygons() async {
  //   try {
  //     final response = await Dio().get('$ip/getsectors');
  //     final body = response.data;
  //     if (body is List<dynamic>) {
  //       final data = body.map((item) => item as Map<String, dynamic>).toList();
  //       // Now you can access the properties of each item in the list
  //       for (final item in data) {
  //         final secId = item['sec_id'] as int;
  //         final secName = item['sec_name'] as String;
  //         final threshold = item['threshold'] as int;
  //         final description = item['description'] as String;
  //         final latLongs = item['latLongs'] as List<dynamic>;

  //         var latLngs = (item['latLongs'] as List<dynamic>)
  //             .map((e) => LatLng(
  //                   double.parse(e.split(',')[0]),
  //                   double.parse(e.split(',')[1]),
  //                 ))
  //             .toList();
  //         if (latLngs.isNotEmpty) {
  //           final polygon = Polygon(
  //             visible: true,
  //             consumeTapEvents: true,
  //             onTap: () {
  //               DraggableMenu.open(
  //                 context,
  //                 DraggableMenu(
  //                   color: tbtnColor,
  //                   uiType: DraggableMenuUiType.softModern,
  //                   expandable: true,
  //                   fastDrag: true,
  //                   minimizeBeforeFastDrag: true,
  //                   expandedHeight: MediaQuery.of(context).size.height * 0.72,
  //                   maxHeight: MediaQuery.of(context).size.height * 0.36,
  //                   child: ScrollableManager(
  //                     enableExpandedScroll: true,
  //                     child: Scaffold(
  //                       backgroundColor: ScfColor,
  //                       body: Padding(
  //                         padding: const EdgeInsets.all(18.0),
  //                         child: SingleChildScrollView(
  //                           child: Column(
  //                             // mainAxisAlignment: MainAxisAlignment.center,
  //                             children: [
  //                               Row(
  //                                 children: [
  //                                   const Text(
  //                                     "Sector Name: ",
  //                                     style: TextStyle(
  //                                       fontWeight: FontWeight.w800,
  //                                       color: grey,
  //                                       fontSize: 15,
  //                                     ),
  //                                   ),
  //                                   Text(
  //                                     secName,
  //                                     style: TextStyle(
  //                                       fontWeight: FontWeight.w800,
  //                                       color: txtColor,
  //                                       fontSize: 15,
  //                                     ),
  //                                   ),
  //                                 ],
  //                               ),
  //                               Row(
  //                                 children: [
  //                                   const Text(
  //                                     "Threshold: ",
  //                                     style: TextStyle(
  //                                       fontWeight: FontWeight.w800,
  //                                       color: grey,
  //                                       fontSize: 15,
  //                                     ),
  //                                   ),
  //                                   Text(
  //                                     "$threshold",
  //                                     style: TextStyle(
  //                                       fontWeight: FontWeight.w800,
  //                                       color: txtColor,
  //                                       fontSize: 15,
  //                                     ),
  //                                   ),
  //                                 ],
  //                               ),
  //                               const Text(
  //                                 "Description",
  //                                 style: TextStyle(
  //                                   fontWeight: FontWeight.w800,
  //                                   color: grey,
  //                                   fontSize: 15,
  //                                 ),
  //                               ),
  //                               Container(
  //                                 height: 110,
  //                                 width: 450,
  //                                 decoration: BoxDecoration(
  //                                   borderRadius: BorderRadius.circular(10),
  //                                   color: ScfColor2,
  //                                 ),
  //                                 child: SingleChildScrollView(
  //                                   child: Padding(
  //                                     padding: const EdgeInsets.all(10.0),
  //                                     child: Text(
  //                                       description,
  //                                       style: const TextStyle(
  //                                         fontWeight: FontWeight.w800,
  //                                         color: grey,
  //                                         fontSize: 12,
  //                                       ),
  //                                     ),
  //                                   ),
  //                                 ),
  //                               ),
  //                               const SizedBox(
  //                                 height: 10,
  //                               ),
  //                               const Text(
  //                                 "Actions Takekn",
  //                                 style: TextStyle(
  //                                   fontWeight: FontWeight.w800,
  //                                   color: grey,
  //                                   fontSize: 15,
  //                                 ),
  //                               ),
  //                               const SizedBox(
  //                                 height: 10,
  //                               ),
  //                               Container(
  //                                 height: 300,
  //                                 width: 400,
  //                                 decoration: BoxDecoration(
  //                                   borderRadius: BorderRadius.circular(10),
  //                                   color: ScfColor2,
  //                                 ),
  //                                 child: Padding(
  //                                   padding: const EdgeInsets.all(8.0),
  //                                   child: ListView.builder(
  //                                     itemCount: 15,
  //                                     itemBuilder: (context, index) {
  //                                       return Card(
  //                                         color: null,
  //                                         child: ListTile(
  //                                           leading: Icon(
  //                                             Icons.warning,
  //                                             color: tbtnColor,
  //                                             size: 33,
  //                                           ),
  //                                           title: Text.rich(
  //                                             TextSpan(
  //                                               text: 'Date: ',
  //                                               style: TextStyle(
  //                                                 fontWeight: FontWeight.w600,
  //                                                 color: txtColor,
  //                                                 fontSize: 13,
  //                                               ),
  //                                               children: const <InlineSpan>[
  //                                                 TextSpan(
  //                                                   text: "2022-11-10",
  //                                                   style: TextStyle(
  //                                                     fontWeight:
  //                                                         FontWeight.w600,
  //                                                     color: grey,
  //                                                     fontSize: 13,
  //                                                   ),
  //                                                 )
  //                                               ],
  //                                             ),
  //                                           ),
  //                                           subtitle: Text(
  //                                             "45576",
  //                                             //"${notifitems[index].datetime!.day}-${notifitems[index].datetime!.month}-${notifitems[index].datetime!.year}",
  //                                             style: TextStyle(
  //                                               fontWeight: FontWeight.w400,
  //                                               color: txtColor,
  //                                               fontSize: 12,
  //                                             ),
  //                                           ),
  //                                           trailing: TextButton(
  //                                             onPressed: () {},
  //                                             child: Text(
  //                                               "View Detail",
  //                                               style: TextStyle(
  //                                                 fontWeight: FontWeight.w400,
  //                                                 color: btnColor,
  //                                                 fontSize: 12,
  //                                               ),
  //                                             ),
  //                                           ),
  //                                         ),
  //                                       );
  //                                     },
  //                                   ),
  //                                 ),
  //                               ),
  //                               const SizedBox(
  //                                 height: 10,
  //                               ),
  //                             ],
  //                           ),
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //                 barrier: true,
  //               );
  //             },
  //             polygonId: PolygonId(secId.toString()),
  //             points: latLngs,
  //             strokeColor: secId == loggedInUser!.sec_id ||
  //                     loggedInUser!.role == "admin" ||
  //                     loggedInUser!.role == "officer"
  //                 ? btnColor
  //                 : Colors
  //                     .transparent, // Change stroke color for logged-in user's polygon
  //             strokeWidth: 1,
  //             fillColor: secId == loggedInUser!.sec_id ||
  //                     loggedInUser!.role == "admin" ||
  //                     loggedInUser!.role == "officer"
  //                 ? btnColor.withOpacity(0.2)
  //                 : Colors
  //                     .transparent, // Change fill color for logged-in user's polygon
  //           );
  //           setState(() {
  //             _polygons.add(polygon);
  //           });
  //         }
  //       }
  //     }
  //   } catch (error) {
  //     print('Failed to fetch polygons: $error');
  //   }
  // }

  Future<void> _fetchPolygons() async {
    try {
      final response = await Dio().get('$ip/getsectors');
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
            // Only add the polygon if the user is an admin or if the polygon is assigned to the user
            if (loggedInUser!.role == "admin" ||
                secId == loggedInUser!.sec_id) {
              final polygon = Polygon(
                visible: true,
                consumeTapEvents: true,
                onTap: () {},
                polygonId: PolygonId(secId.toString()),
                points: latLngs,
                strokeColor: secId == loggedInUser!.sec_id
                    ? btnColor
                    : const Color.fromARGB(255, 74, 216,
                        192), // Change stroke color for logged-in user's polygon
                strokeWidth: 1,
                fillColor: secId == loggedInUser!.sec_id
                    ? btnColor.withOpacity(0.2)
                    : const Color.fromARGB(255, 74, 216, 192).withOpacity(
                        0.2), // Change fill color for logged-in user's polygon
              );
              setState(() {
                _polygons.add(polygon);
              });
            }
          }
        }
      }
    } catch (error) {
      print('Failed to fetch polygons: $error');
    }
  }

  // Future<void> _fetchPolygons() async {
  //   try {
  //     final response = await Dio().get('$ip/getsectors');
  //     final body = response.data;
  //     if (body is List<dynamic>) {
  //       final data = body.map((item) => item as Map<String, dynamic>).toList();
  //       for (final item in data) {
  //         final secId = item['sec_id'] as int;
  //         final secName = item['sec_name'] as String;
  //         final threshold = item['threshold'] as int;
  //         final description = item['description'] as String;
  //         final latLongs = item['latLongs'] as List<dynamic>;

  //         // Filter polygons based on logged-in user's sector ID

  //         if (secId == loggedInUser!.sec_id) {
  //           var latLngs = (item['latLongs'] as List<dynamic>)
  //               .map((e) => LatLng(
  //                     double.parse(e.split(',')[0]),
  //                     double.parse(e.split(',')[1]),
  //                   ))
  //               .toList();
  //           if (latLngs.isNotEmpty) {
  //             final polygon = Polygon(
  //               visible: true,
  //               consumeTapEvents: true,
  //               onTap: () {
  //                 getDialogue(context, "$secName\n$threshold");
  //               },
  //               polygonId: PolygonId(secId.toString()),
  //               points: latLngs,
  //               strokeColor: Colors.blue,
  //               strokeWidth: 3,
  //               fillColor: Colors.blue.withOpacity(0.2),
  //             );
  //             setState(() {
  //               _polygons.add(polygon);
  //             });
  //           }
  //         }
  //       }
  //     }
  //   } catch (error) {
  //     print('Failed to fetch polygons: $error');
  //   }
  // }

// Future<User?> _getUser() async {
//   final prefs = await SharedPreferences.getInstance();
//   final userId = prefs.getInt('user_id');
//   if (userId != null) {
//     final response = await Dio().get('$ip/getuser/$userId');
//     final body = response.data;
//     if (body is Map<String, dynamic>) {
//       return User.fromJson(body);
//     }
//   }
//   return null;
// }
  bool? ismoving = false;
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
                  //polygons: getPolygons(context),
                  polygons: _polygons,

                  onCameraMoveStarted: () {
                    // notify map is moving

                    setState(() {
                      mapPickerController.mapMoving!();
                      addressController.text = "checking ...";
                      ismoving = true;
                    });
                  },
                  onCameraMove: (cameraPosition) {
                    this.cameraPosition = cameraPosition;
                    _customInfoWindowController.onCameraMove!();
                  },
                  onCameraIdle: () async {
                    // notify map stopped moving
                    mapPickerController.mapFinishedMoving!();
                    //get address name from camera position
                    List<Placemark> placemarks = await placemarkFromCoordinates(
                      cameraPosition.target.latitude,
                      cameraPosition.target.longitude,
                    );
                    setState(() {
                      ismoving = false;
                    });

                    // update the ui with the address
                    addressController.text =
                        '${placemarks.first.name},${placemarks.first.subLocality}, ${placemarks.first.locality}, ${placemarks.first.country}';
                    //'${placemarks.first.name}, ${placemarks.first.postalCode}, ${placemarks.first.subLocality}, ${placemarks.first.locality}, ${placemarks.first.administrativeArea}, ${placemarks.first.country}';
                  },
                ),
              ),
              ismoving! == false
                  ? Positioned(
                      top: 60,
                      left: 15,
                      right: 15,
                      child: Container(
                        alignment: Alignment.bottomCenter,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: ScfColor2.withOpacity(.8),
                        ),
                        //padding: const EdgeInsets.only(bottom: 16.0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 150.0,
                          child: SfCartesianChart(
                            zoomPanBehavior: ZoomPanBehavior(
                              enablePanning: true,
                            ),
                            primaryXAxis: CategoryAxis(
                              autoScrollingMode: AutoScrollingMode.start,
                              visibleMaximum: 5,
                              interval: 1,
                            ),
                            // borderColor: ScfColor,
                            // borderWidth: 2,
                            //backgroundColor: ScfColor,
                            primaryYAxis: NumericAxis(
                              interval: 1,
                            ),
                            tooltipBehavior: _tooltip,
                            series: <ChartSeries<_ChartData, String>>[
                              FastLineSeries<_ChartData, String>(
                                dataSource: _chartData,
                                xValueMapper: (_ChartData data, _) => data.date,
                                yValueMapper: (_ChartData data, _) =>
                                    data.cases,
                                name: 'Dengue Cases',

                                color: btnColor,

                                //width: .2,
                                // borderRadius: const BorderRadius.only(
                                //   topLeft: Radius.circular(5.0),
                                //   topRight: Radius.circular(5.0),
                                // ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : const SizedBox(),

              //
              ////
              /////
              // //My Address Field
              //My Address Field
              Positioned(
                top: MediaQuery.of(context).viewPadding.top + 10,
                width: MediaQuery.of(context).size.width - 70,
                height: 150,
                left: 15,
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
              ismoving == false
                  ? Positioned(
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
                                          MediaQuery.of(context).size.height *
                                              0.3,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount: _mapThemes.length,
                                                itemBuilder: (context, index) {
                                                  return GestureDetector(
                                                    onTap: () {
                                                      _control!.setMapStyle(
                                                        _mapThemes[index]
                                                            ['style'],
                                                      );
                                                      Navigator.pop(context);
                                                    },
                                                    child: Container(
                                                      width: 100,
                                                      margin:
                                                          const EdgeInsets.only(
                                                              right: 10),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          image:
                                                              DecorationImage(
                                                            fit: BoxFit.cover,
                                                            image: NetworkImage(
                                                                _mapThemes[
                                                                        index]
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
                    )
                  : const SizedBox(),

              //Zoom Selection Button
              ismoving == false
                  ? Positioned(
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
                                  _control!
                                      .animateCamera(CameraUpdate.zoomIn());
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
                                  _control!
                                      .animateCamera(CameraUpdate.zoomOut());
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
                    )
                  : const SizedBox(),

              //Slider
              Positioned(
                bottom: -5,
                left: 60,
                child: Row(
                  //mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        ismoving == false
                            ? Row(
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
                              )
                            : const SizedBox(),
                        SizedBox(
                          width: 300,
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
            ],
          ),
        ),
      ),
    );
  }
}

// class _ChartData {
//   _ChartData(this.date, this.cases);

//   final DateTime date;
//   final int cases;

//   double get latitude => // Get latitude based on date
//       // Example: latitude increases as the year progresses
//       1.0 + (date.year - 2022) * 0.1;

//   double get longitude => // Get longitude based on date
//       // Example: longitude increases as the month progresses
//       -1.0 - date.month * 0.1;
// }

// class _ChartData {
//   _ChartData(this.date, this.cases);

//   final DateTime date;
//   final int cases;

//   double get latitude => 1.0 + (date.year - 2022) * 0.1;

//   double get longitude => -1.0 - date.month * 0.1;
// }
