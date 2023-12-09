import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:green_burgas_explorer/closer_polyngon.dart';
import 'package:green_burgas_explorer/map.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/services.dart';

class Point {
  double latitude;
  double longitude;

  Point({required this.latitude, required this.longitude});

  factory Point.fromJson(Map<String, dynamic> json) {
    return Point(
      latitude: json['latitude'] ?? 0.0,
      longitude: json['longitude'] ?? 0.0,
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Map<String, dynamic> polygonsData = {};

  @override
  void initState() {
    super.initState();
    loadJsonData();
  }

  Future<void> loadJsonData() async {
    try {
      // Get the JSON file path
      String jsonString = await rootBundle.loadString('data/polygons_coordinates.json');

      // Parse the JSON string
      Map<String, dynamic> jsonData = json.decode(jsonString);

      // Update the state with the loaded data
      setState(() {
        polygonsData = jsonData;
      });

      // Calculate and print the area for each polygon
      for (int i = 1; i <= polygonsData.length; i++) {
        String polygonKey = 'polygon$i';
        if (polygonsData.containsKey(polygonKey)) {
          List<Point> points = (polygonsData[polygonKey]['points'] as List<dynamic>)
              .map<Point>((dynamic point) => Point.fromJson(point))
              .toList();
          double area = polygonArea(points);
          print('Area of $polygonKey: $area');
        }
      }
    } catch (e) {
      print('Error loading JSON data: $e');
    }
  }

  double polygonArea(List<Point> points) {
    if (points.length < 3) return 0.0;

    double area = 0.0;

    for (int i = 0; i < points.length - 1; i++) {
      area += points[i].latitude * points[i + 1].longitude -
          points[i + 1].latitude * points[i].longitude;
    }

    // Затваряне на многоъгълника
    area += points[points.length - 1].latitude * points[0].longitude -
        points[0].latitude * points[points.length - 1].longitude;

    return area.abs() / 2.0;
  }

  @override
  Widget build(BuildContext context) {
    // No UI elements needed for printing only
    return Scaffold(
      appBar: AppBar(
        title: const Text('GreenBurgas Explorer'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          MapWidget(polygonsData: polygonsData), // Pass the loaded data to MapWidget
          Positioned(
            bottom: 16.0,
            right: 16.0,
            child: ClipOval(
              child: Material(
                color: Colors.blue, // Цвят на кръга
                child: InkWell(
                  onTap: () async {
                    try {
                      Position position = await determinePosition();
                      print(
                          'Latitude: ${position.latitude}, Longitude: ${position.longitude}');
                    } catch (e) {
                      print('Грешка при вземане на локацията: $e');
                    }
                  },
                  child: const SizedBox(
                    width: 56,
                    height: 56,
                    child: Icon(
                      FontAwesomeIcons.locationCrosshairs,
                      color: Colors.white, // Цвят на иконата
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
