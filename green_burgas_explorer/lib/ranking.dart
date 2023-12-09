import 'main.dart';

void main() {
  List<double> areas = [
    area1,
    area2,
    area3,
    area4,
    area5,
    area6
  ]; // Примерни площи на многоъгълници

  // Сортиране на площите от най-голяма към най-малка
  areas.sort((a, b) => b.compareTo(a));

  print("Класация на площите от най-голяма към най-малка: $areas");
}
