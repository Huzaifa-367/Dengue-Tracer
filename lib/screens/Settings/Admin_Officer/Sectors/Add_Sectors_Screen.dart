import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

class Add_Sector_Screen extends StatefulWidget {
  const Add_Sector_Screen({super.key});

  @override
  State<Add_Sector_Screen> createState() => _Add_Sector_ScreenState();
}

class _Add_Sector_ScreenState extends State<Add_Sector_Screen> {
  late List<MapLatLng> _polygon;

  @override
  void initState() {
    _polygon = <MapLatLng>[
      const MapLatLng(33.644217, 73.074658),
      const MapLatLng(33.644065, 73.080516),
      const MapLatLng(33.642175, 73.082333),
      const MapLatLng(33.640020, 73.080607),
      const MapLatLng(33.637373, 73.077156),
      const MapLatLng(33.638243, 73.071434),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SfMaps(
      layers: [
        MapTileLayer(
          initialZoomLevel: 15,
          initialFocalLatLng: const MapLatLng(33.643005, 73.077706),
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          sublayers: [
            MapPolygonLayer(
              polygons: {
                MapPolygon(
                  points: _polygon,
                  color: Colors.amber,
                  strokeColor: Colors.pink[800],
                  strokeWidth: 3,
                )
              },
            ),
          ],
        ),
      ],
    );
  }
}
