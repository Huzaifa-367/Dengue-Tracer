import 'dart:convert';

import 'package:dengue_tracing_application/Global/constant.dart';
import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

getDengueUsers() async {
  var response = await Dio().get('$ip/GetDengueUsers');

  if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(response.data);

    markers = data.map((item) {
      final LatLng latLng = LatLng(item['lat_long'][0], item['lat_long'][1]);
      final String title = item['name'];
      final String snippet = item['email'];

      return Marker(
        markerId: MarkerId(title),
        position: latLng,
        infoWindow: InfoWindow(
          title: title,
          snippet: snippet,
        ),
      );
    }).toList();
  } else {
    throw Exception('Failed to fetch dengue users.');
  }
}

