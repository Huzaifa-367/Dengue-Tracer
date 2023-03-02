import 'package:dengue_tracing_application/Global/constant.dart';
import 'package:dengue_tracing_application/Global/text_widget.dart';
import 'package:dengue_tracing_application/Global/txtfield_Round.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:map_picker/map_picker.dart';
import 'package:geocoding/geocoding.dart';

class MapTest2 extends StatefulWidget {
  const MapTest2({Key? key}) : super(key: key);

  @override
  _MapTest2State createState() => _MapTest2State();
}

class _MapTest2State extends State<MapTest2> {
  final _controller = Completer<GoogleMapController>();
  MapPickerController mapPickerController = MapPickerController();

  CameraPosition cameraPosition = const CameraPosition(
    target: LatLng(33.643005, 73.077706),
    zoom: 14.4746,
  );

  var textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          MyTextField(
            controller: textController,
            hintText: "Location",
            keytype: TextInputType.text,
            obscureText: false,
            prefixIcon: const Icon(Icons.map),
            sufixIcon: Icons.pin_drop,
          ),
          TextButton(
            onPressed: () {
              print(
                  "Location ${cameraPosition.target.latitude} ${cameraPosition.target.longitude}");
              print("Address: ${textController.text}");
            },
            child: Container(
              decoration: BoxDecoration(
                color: btnColor,
                borderRadius: BorderRadius.circular(25),
              ),
              padding:
                  const EdgeInsets.only(top: 10, right: 8, bottom: 10, left: 8),
              child: const TextWidget(
                  title: "  Save  ", txtSize: 15, txtColor: Colors.white),
            ),
          ),
          SizedBox(
            height: 600,
            child: MapPicker(
              // pass icon widget
              iconWidget: SvgPicture.asset(
                "assets/icons/Location point.svg",
                height: 60,
              ),
              //add map picker controller
              mapPickerController: mapPickerController,
              child: GoogleMap(
                myLocationEnabled: true,
                zoomControlsEnabled: false,
                // hide location button
                myLocationButtonEnabled: false,
                mapType: MapType.normal,
                //  camera position
                initialCameraPosition: cameraPosition,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
                onCameraMoveStarted: () {
                  // notify map is moving
                  mapPickerController.mapMoving!();
                  textController.text = "checking ...";
                },
                onCameraMove: (cameraPosition) {
                  this.cameraPosition = cameraPosition;
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
                  textController.text =
                      '${placemarks.first.name}, ${placemarks.first.postalCode}, ${placemarks.first.subLocality}, ${placemarks.first.locality}, ${placemarks.first.administrativeArea}, ${placemarks.first.country}';
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
