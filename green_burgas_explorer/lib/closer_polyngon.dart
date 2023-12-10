import 'package:geolocator/geolocator.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

// Function to determine the user's current position
Future<Position> determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied by the user.');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error(
        'Location permissions are permanently denied, and we cannot request permissions.');
  }

  return await Geolocator.getCurrentPosition();
}

// Function to load polygons from a JSON file
Future<Map<String, dynamic>> loadPolygons() async {
  // Load your JSON file here, for example, from assets:
  String jsonString =
      await rootBundle.loadString('data/polygons_coordinates.json');
  return json.decode(jsonString);
}

// Function to calculate the distance between the user and a polygon
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

// Function to find the nearest polygon to the user's position
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

  // Extract the last character from the nearest polygon key
  String lastCharacter = nearestPolygonKey.substring(nearestPolygonKey.length - 1);

  return lastCharacter;
}
