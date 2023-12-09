class Point {
  double x;
  double y;

  Point(this.x, this.y);
}

double polygonArea(List<Point> points) {
  if (points.length < 3) return 0.0;

  double area = 0.0;

  for (int i = 0; i < points.length - 1; i++) {
    area += points[i].x * points[i + 1].y - points[i + 1].x * points[i].y;
  }

  // Затваряне на многоъгълника
  area += points[points.length - 1].x * points[0].y -
      points[0].x * points[points.length - 1].y;

  return area.abs() / 2.0;
}
