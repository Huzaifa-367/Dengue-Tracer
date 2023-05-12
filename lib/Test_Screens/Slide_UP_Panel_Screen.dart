/*
 https://github.com/akshathjain/sliding_up_panel
*/

import 'dart:ui';

import 'package:dengue_tracing_application/Global/Widgets/SlideUp_Panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class SlidingUpPanelExample extends StatelessWidget {
  const SlidingUpPanelExample({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.grey[200],
      systemNavigationBarIconBrightness: Brightness.dark,
      systemNavigationBarDividerColor: Colors.black,
    ));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SlidingUpPanel Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CameraPosition cameraPosition = const CameraPosition(
    target: LatLng(33.643005, 73.077706),
    zoom: 15,
  );

  final double _initFabHeight = 120.0;
  double _fabHeight = 0;
  double _panelHeightOpen = 0;
  final double _panelHeightClosed = 95.0;

  @override
  void initState() {
    super.initState();

    _fabHeight = _initFabHeight;
  }

  @override
  Widget build(BuildContext context) {
    _panelHeightOpen = MediaQuery.of(context).size.height * .80;

    return Material(
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          SlidingUpPanel(
            maxHeight: _panelHeightOpen,
            minHeight: _panelHeightClosed,
            parallaxEnabled: true,
            parallaxOffset: .5,
            body: _body(),
            panelBuilder: (sc) => _panel(sc),
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(18.0),
                topRight: Radius.circular(18.0)),
            onPanelSlide: (double pos) => setState(() {
              _fabHeight = pos * (_panelHeightOpen - _panelHeightClosed) +
                  _initFabHeight;
            }),
          ),

          // the fab
          Positioned(
            right: 20.0,
            bottom: _fabHeight,
            child: FloatingActionButton(
              onPressed: () {},
              backgroundColor: Colors.white,
              child: Icon(
                Icons.gps_fixed,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),

          Positioned(
              top: 0,
              child: ClipRRect(
                  child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).padding.top,
                        color: Colors.transparent,
                      )))),

          //the SlidingUpPanel Title
          Positioned(
            top: 52.0,
            child: Container(
              padding: const EdgeInsets.fromLTRB(24.0, 18.0, 24.0, 18.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24.0),
                boxShadow: const [
                  BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, .25), blurRadius: 16.0)
                ],
              ),
              child: const Text(
                "SlidingUpPanel Example",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _panel(ScrollController sc) {
    return MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView(
          controller: sc,
          children: <Widget>[
            const SizedBox(
              height: 12.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 30,
                  height: 5,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius:
                          const BorderRadius.all(Radius.circular(12.0))),
                ),
              ],
            ),
            const SizedBox(
              height: 18.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                Text(
                  "Explore Pittsburgh",
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 24.0,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 36.0,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _button("Popular", Icons.favorite, Colors.blue),
                const SizedBox(
                  height: 20,
                ),
                _button("Food", Icons.restaurant, Colors.red),
                const SizedBox(
                  height: 20,
                ),
                _button("Events", Icons.event, Colors.amber),
                const SizedBox(
                  height: 20,
                ),
                _button("More", Icons.more_horiz, Colors.green),
              ],
            ),
            const SizedBox(
              height: 36.0,
            ),
            const SizedBox(
              height: 36.0,
            ),
            Container(
              padding: const EdgeInsets.only(left: 24.0, right: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  Text("About",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      )),
                  SizedBox(
                    height: 12.0,
                  ),
                  Text(
                    """Pittsburgh is a city in the state of Pennsylvania in the United States, and is the county seat of Allegheny County. A population of about 302,407 (2018) residents live within the city limits, making it the 66th-largest city in the U.S. The metropolitan population of 2,324,743 is the largest in both the Ohio Valley and Appalachia, the second-largest in Pennsylvania (behind Philadelphia), and the 27th-largest in the U.S.\n
                   """,
                    softWrap: true,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 24,
            ),
          ],
        ));
  }

  Widget _button(String label, IconData icon, Color color) {
    return Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              boxShadow: const [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.15),
                  blurRadius: 8.0,
                )
              ]),
          child: Icon(
            icon,
            color: Colors.white,
          ),
        ),
        const SizedBox(
          height: 12.0,
        ),
        Text(label),
      ],
    );
  }

  Widget _body() {
    return GoogleMap(
      initialCameraPosition: cameraPosition,
    );
  }
}
