import 'package:dengue_tracing_application/Global/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_place_picker/flutter_place_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// Your api key storage.

class PickLoc extends StatefulWidget {
  const PickLoc({Key? key}) : super(key: key);

  @override
  _PickLocState createState() => _PickLocState();
}

class _PickLocState extends State<PickLoc> {
  PickResult? selectedPlace;

  final LatLng kInitialPosition = const LatLng(33.643005, 73.077706);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Google Map Place Picker Demo"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                child: const Text("Load Google Map"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return FlutterPlacePicker(
                          apiKey:
                              mapapikey, // Needed to display google maps and
                          initialPosition: kInitialPosition,
                          useCurrentLocation: true,
                          selectInitialPosition: true,
                          usePlaceDetailSearch: false,
                          region: 'gh',
                          strictBounds: true,

                          onPlacePicked: (result) {
                            selectedPlace = result;

                            print(result.geometry!.location.lat);
                            print(result.geometry!.location.lng);
                            print(result.placeId);
                            print(result.formattedAddress);

                            Navigator.of(context).pop();
                            setState(() {});
                          },
                          // serverUrl: "https://www.your-server.com/api/",
                          //automaticallyImplyAppBarLeading: false,
                          // selectedPlaceWidgetBuilder: (_, selectedPlace, state, isSearchBarFocused) {
                          //   print("state: $state, isSearchBarFocused: $isSearchBarFocused");
                          //   return isSearchBarFocused
                          //       ? Container()
                          //       : FloatingCard(
                          //           bottomPosition: 0.0, // MediaQuery.of(context) will cause rebuild. See MediaQuery document for the information.
                          //           leftPosition: 0.0,
                          //           rightPosition: 0.0,
                          //           width: 500,
                          //           borderRadius: BorderRadius.circular(12.0),
                          //           child: state == SearchingState.Searching
                          //               ? Center(child: CircularProgressIndicator())
                          //               : RaisedButton(
                          //                   child: Text("Pick Here"),
                          //                   onPressed: () {
                          //                     // IMPORTANT: You MUST manage selectedPlace data yourself as using this build will not invoke onPlacePicker as
                          //                     //            this will override default 'Select here' Button.
                          //                     print("do something with [selectedPlace] data");
                          //                     Navigator.of(context).pop();
                          //                   },
                          //                 ),
                          //         );
                          // },
                          // pinBuilder: (context, state) {
                          //   if (state == PinState.Idle) {
                          //     return Icon(Icons.favorite_border);
                          //   } else {
                          //     return Icon(Icons.favorite);
                          //   }
                          // },
                        );
                      },
                    ),
                  );
                },
              ),
              selectedPlace == null
                  ? Container()
                  : Text(selectedPlace!.formattedAddress ?? ""),
            ],
          ),
        ));
  }
}
