import 'package:geolocator/geolocator.dart';

Future<Position> determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Проверка дали локационните услуги са активирани
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

  // Вземане на текущата локация
  return await Geolocator.getCurrentPosition();
}
