class Point {
  double latitude;
  double longitude;

  Point(this.latitude, this.longitude);

  factory Point.fromJson(Map<String, dynamic> json) {
    return Point(json['latitude'], json['longitude']);
  }
}

class CustomPolygon {
  List<Point> points;

  CustomPolygon(this.points);

  factory CustomPolygon.fromJson(Map<String, dynamic> json) {
    List<dynamic> jsonPoints = json['points'];
    List<Point> points =
    jsonPoints.map((jsonPoint) => Point.fromJson(jsonPoint)).toList();
    return CustomPolygon(points);
  }
}

double polygonArea(List<Point> points) {
  if (points.length < 3) return 0.0;

  double area = 0.0;

  for (int i = 0; i < points.length - 1; i++) {
    area += points[i].latitude * points[i + 1].longitude -
        points[i + 1].latitude * points[i].longitude;
  }

  // Closing the polygon
  area += points[points.length - 1].latitude * points[0].longitude -
      points[0].latitude * points[points.length - 1].longitude;

  return area.abs() / 2.0;
}
