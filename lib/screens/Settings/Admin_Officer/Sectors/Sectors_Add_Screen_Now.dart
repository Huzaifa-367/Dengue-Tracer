import 'dart:async';
import 'package:dengue_tracing_application/Global/GetDialogue_tester.dart';
import 'package:dengue_tracing_application/Global/SnackBar_widget.dart';
import 'package:dengue_tracing_application/Global/constant.dart';
import 'package:dengue_tracing_application/Global/text_widget.dart';
import 'package:dengue_tracing_application/Global/txtfield_Round.dart';
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
  late final GoogleMapController _mapController;
  final Set<Polygon> _polygons = {};
  final List<LatLng> _currentPolygon = [];
  bool _isDrawing = false;
  TextEditingController namecont = TextEditingController();
  TextEditingController thresholdcont = TextEditingController();
  TextEditingController descriptioncont = TextEditingController();

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

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

  Future<void> _savePolygons(Set<Polygon> polygons, context) async {
    // Create the request body as a JSON object

    final Map<String, dynamic> requestBody = {
      'secName': namecont.text,
      'threshold': thresholdcont.text,
      'description': descriptioncont.text,
      'latLongs': _currentPolygon
    };

    // Send the HTTP request
    try {
      final Response response =
          await Dio().post('$ip/SavePolygons', data: requestBody);

      // Check if the request was successful
      if (response.statusCode == 200) {
        // Handle the success response
        snackBar(context, "New Sector Has been added Successfully");
        //print('Polygons saved successfully: ${response.data}');
        //snackBar(context, 'Polygons saved successfully');
      } else {
        // Handle the error response
        snackBar(context, 'Failed to save polygons: ${response.data}');
        // print('Failed to save polygons: ${response.data}');
      }
    } catch (error) {
      // Handle any errors that occur during the request
      snackBar(context, 'Failed to save polygons:');
      //print('Failed to save polygons: $error');
    }
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
              consumeTapEvents: _isDrawing == false ? true : false,
              onTap: () {
                getDialogue(context, "$secName\n$threshold");
              },
              polygonId: PolygonId(secId.toString()),
              points: latLngs,
              strokeColor: const Color.fromARGB(255, 74, 216, 192),
              strokeWidth: 1,
              fillColor:
                  const Color.fromARGB(255, 74, 216, 192).withOpacity(0.2),
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
        title: const Text('Polygon Saver'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save_as_rounded),
            onPressed: () {
              getWidgetDialogue(
                context,
                [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              onPressed: (() {
                                Navigator.of(context).pop();
                              }),
                              icon: const Icon(Icons.cancel_outlined),
                            ),
                          ],
                        ),
                        MyTextField(
                          maxlines: 1,
                          //siconn: Icons.email,
                          controller: namecont,
                          hintText: "Sector Name",

                          obscureText: false,
                          prefixIcon: const Icon(Icons.email),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        MyTextField(
                          controller: thresholdcont,
                          hintText: "Threshold",
                          obscureText: false,
                          maxlines: 1,
                          prefixIcon: const Icon(Icons.numbers_rounded),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        MyTextField(
                          controller: descriptioncont,
                          hintText: "Description",
                          maxlines: 5,
                          obscureText: false,
                          prefixIcon: const Icon(Icons.description_rounded),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();

                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //       builder: (context) =>
                                //           const OfficersListScreen(),
                                //     ),
                                // );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: btnColor,
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 10,
                                ),
                                child: const TextWidget(
                                    title: "Cancel",
                                    txtSize: 15,
                                    txtColor: Colors.white),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                _savePolygons(_polygons, context);

                                // Navigator.of(context).pop();
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: btnColor,
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 10,
                                ),
                                child: const TextWidget(
                                    title: "Save",
                                    txtSize: 15,
                                    txtColor: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          GoogleMap(
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
              _mapController = controller;
              _fetchPolygons();
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _toggleDrawing,
        child: Icon(_isDrawing ? Icons.stop : Icons.play_arrow),
      ),
    );
  }
}
