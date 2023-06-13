import 'package:google_maps_cluster_manager/google_maps_cluster_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Place with ClusterItem {
  final String stationId;
  final LatLng latLng;
  //final Status status;
  final BitmapDescriptor? icon;

  Place(
      {required this.stationId,
      required this.latLng,
      //required this.status,
      this.icon = BitmapDescriptor.defaultMarker});

  @override
  String toString() {
    return 'Place $stationId (status : $stationId)';
  }

  @override
  LatLng get location => latLng;
}