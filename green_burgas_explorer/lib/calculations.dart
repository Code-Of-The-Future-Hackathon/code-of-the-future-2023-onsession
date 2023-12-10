// Represents a geographic point with latitude and longitude
class Point {
  double latitude;
  double longitude;

  // Constructor for creating a Point object
  Point(this.latitude, this.longitude);

  // Factory method to create a Point object from a JSON map
  factory Point.fromJson(Map<String, dynamic> json) {
    return Point(json['latitude'], json['longitude']);
  }
}

// Represents a custom polygon composed of a list of points
class CustomPolygon {
  List<Point> points;

  // Constructor for creating a CustomPolygon object
  CustomPolygon(this.points);

  // Factory method to create a CustomPolygon object from a JSON map
  factory CustomPolygon.fromJson(Map<String, dynamic> json) {
    // Extract the list of points from the JSON map and convert them to Point objects
    List<dynamic> jsonPoints = json['points'];
    List<Point> points =
        jsonPoints.map((jsonPoint) => Point.fromJson(jsonPoint)).toList();
    return CustomPolygon(points);
  }
}

// Calculates the area of a polygon defined by a list of points
double polygonArea(List<Point> points) {
  // Check if there are less than 3 points (not a valid polygon)
  if (points.length < 3) return 0.0;

  double area = 0.0;

  for (int i = 0; i < points.length - 1; i++) {
    // Use the shoelace formula to calculate the area of each small triangle
    area += points[i].latitude * points[i + 1].longitude -
        points[i + 1].latitude * points[i].longitude;
  }

  // Close the polygon by adding the area between the last and first points
  area += points[points.length - 1].latitude * points[0].longitude -
      points[0].latitude * points[points.length - 1].longitude;

  // Return the absolute value of the calculated area divided by 2.0
  return area.abs() / 2.0;
}
