import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:green_burgas_explorer/calculations.dart';

class MapWidget extends StatelessWidget {
  final Map<String, dynamic> polygonsData; // Declare the polygonsData variable

  MapWidget({required this.polygonsData});

  @override
  Widget build(BuildContext context) {
    List<CustomPolygon> polygons = [];

    // Iterate through polygonsData and create CustomPolygon objects
    for (int i = 1; i <= polygonsData.length; i++) {
      String polygonKey = 'polygon$i';
      if (polygonsData.containsKey(polygonKey)) {
        List<Point> points = (polygonsData[polygonKey]['points'] as List<dynamic>)
            .map<Point>((dynamic point) => Point.fromJson(point))
            .toList();
        polygons.add(CustomPolygon(points));
      }
    }

    return FlutterMap(
      options: const MapOptions(
        initialCenter: LatLng(42.50655514080855, 27.465892134392316),
        maxZoom: 16.0,
        minZoom: 2.0,
        initialZoom: 13.0,
        interactiveFlags: InteractiveFlag.pinchZoom | InteractiveFlag.drag,
      ),
      children: [
        TileLayer(
          urlTemplate:
          'https://cartodb-basemaps-{s}.global.ssl.fastly.net/rastertiles/voyager/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.app',
        ),
        // Use the CustomPolygon class
        for (CustomPolygon polygon in polygons)
          PolygonLayer(
            polygons: [
              Polygon(
                points: polygon.points.map((point) => LatLng(point.latitude, point.longitude)).toList(),
                color: Colors.green,
                isFilled: true,
                borderColor: Colors.white, // Set the color of the border
                borderStrokeWidth: 2.0,
              )
            ],
          ),
      ],
    );
  }
}