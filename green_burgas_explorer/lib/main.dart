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

List<String> names = [
  'Morska gradina',
  'Park "Ezero"',
  'Park "Izgrev"',
  'Park "Sveta Troica"',
  'Park "Slaveykov"',
  'Borisova gradina',
];
List<String> description = [
  "History of the park, types of plants and animals. Sports facilities, places for relaxation, cafes. Information about transport and parking.",
  "Features of the park, types of plants and animals. Children's playgrounds, relaxation zones, sports facilities. Opportunities for sports and walks.",
  "Diversity of flora and fauna, historical landmarks. Recreation areas, sports fields, cafes. Opportunities for organizing events and activities.",
  "Main characteristics, historical significance, types of plants and animals. Places for recreation, children's playgrounds, sports facilities. Information about cultural and sports events held there.",
  "Historical and cultural value, natural features. Benches, walking paths, children's corners. Information about cultural events and festivals held.",
  "Information about the lake, surrounding nature, historical value. Picnic areas, fishing spots, walking trails. Transport links, parking.",
];

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
  List<String> stringCapacity = ['600дка', '341дка', '146дка', '132дка', "119дка", '97дка'];

  @override
  void initState() {
    super.initState();
    loadJsonData();
  }

  // Function to show the nearest polygon dialog
  void _showLeaderboard1() {
    findNearestPolygon().then((nearestPolygonKey) {
      int index = names.indexOf(nearestPolygonKey);
      index = index * -1 - 1;
      if (index != -1) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text('The nearest green area is ${names[index]}'),
              actions: <Widget>[
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      } else {
        print("Nearest polygon not found in names list ${index}");
      }
    });
  }

  // Function to show the leaderboard dialog
  void _showLeaderboard() {
    List<MapEntry<String, double>> areas = [];

    for (int i = 1; i <= polygonsData.length; i++) {
      String polygonKey = 'polygon$i';
      if (polygonsData.containsKey(polygonKey)) {
        List<Point> points = (polygonsData[polygonKey]['points'] as List<dynamic>)
            .map<Point>((dynamic point) => Point.fromJson(point))
            .toList();
        double area = polygonArea(points);
        areas.add(MapEntry(polygonKey, area));
      }
    }

    // Sort the areas from largest to smallest
    areas.sort((a, b) => b.value.compareTo(a.value));

    // Show the sorted list in a dialog or a new screen
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // Create a list of Text widgets for each area
        List<Widget> areaWidgets = [];
        for (int i = 0; i < areas.length; i++) {
          areaWidgets.add(Text('${names[i]}: ${stringCapacity[i]}'));
        }

        return AlertDialog(
          title: Text('Leaderboard'),
          content: SingleChildScrollView(
            child: ListBody(
              children: areaWidgets,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // Function to show a dialog with name and description
  void _showDialog(BuildContext context, String name, String option) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
            child: Text(name),
          ),
          content: Text(option),
          actions: <Widget>[
            TextButton(
              child: Text(
                'OK',
                style: TextStyle(color: Colors.green),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // Function to load JSON data
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

  // Function to calculate the area of a polygon
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
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'GreenBurgas Explorer',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.green, // Change the background color
        elevation: 0, // Remove the shadow beneath the app bar
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              height: 100, // Set the height to your desired value
              child: const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.green,
                ),
                child: Center(
                  child: Text(
                    'Green spaces',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
            ),
            for (int i = 0; i < names.length; i++)
              ListTile(
                title: Text(names[i]),
                onTap: () => _showDialog(context, names[i], description[i]),
              ),
          ],
        ),
      ),
      body: Stack(
        children: [
          MapWidget(polygonsData: polygonsData), // Pass the loaded data to MapWidget
          Positioned(
            bottom: 16.0,
            right: 16.0,
            child: ClipOval(
              child: Material(
                color: Colors.green, // Цвят на кръга
                child: InkWell(
                  onTap: () async {
                    try {
                      Position position = await determinePosition();
                      print('Latitude: ${position.latitude}, Longitude: ${position.longitude}');

                      _showLeaderboard1();

                      findNearestPolygon().then((nearestPolygonKey) {
                        print(nearestPolygonKey);
                      });
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
          Positioned(
            bottom: 16.0,
            left: 16.0,
            child: FloatingActionButton(
              backgroundColor: Colors.green,
              onPressed: _showLeaderboard,
              child: const Icon(
                FontAwesomeIcons.trophy,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
