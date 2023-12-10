import 'package:geolocator/geolocator.dart';
import 'dart:convert';
import 'package:flutter/services.dart';



Future<Position> determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Локационните услуги са деактивирани.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error(
          'Разрешенията за локация са отказани от потребителя.');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error(
        'Разрешенията за локация са постоянно отказани, не можем да поискаме разрешения.');
  }

  return await Geolocator.getCurrentPosition();
}

Future<Map<String, dynamic>> loadPolygons() async {
  // Load your JSON file here. For example, you might load it from assets:
  String jsonString = await rootBundle.loadString('data/polygons_coordinates.json');
  return json.decode(jsonString);
}

double calculateDistance(Position userPosition, List<dynamic> polygonPoints) {
  double minDistance = double.infinity;
  for (var point in polygonPoints) {
    double distance = Geolocator.distanceBetween(
      userPosition.latitude,
      userPosition.longitude,
      point['latitude'],
      point['longitude'],
    );
    if (distance < minDistance) {
      minDistance = distance;
    }
  }
  return minDistance;
}

Future<String> findNearestPolygon() async {
  Position userPosition = await determinePosition();
  Map<String, dynamic> polygons = await loadPolygons();
  String nearestPolygonKey = ""; // Initialized with an empty string
  double nearestDistance = double.infinity;

  polygons.forEach((key, value) {
    double distance = calculateDistance(userPosition, value['points']);
    if (distance < nearestDistance) {
      nearestDistance = distance;
      nearestPolygonKey = key;
    }
  });


  String lastCharacter = nearestPolygonKey.substring(nearestPolygonKey.length - 1);

  return lastCharacter;
}
