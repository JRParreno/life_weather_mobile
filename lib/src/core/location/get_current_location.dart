import 'package:geolocator/geolocator.dart';

Future<Position> getCurrentLocation() async {
  final gpsLocation = await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.bestForNavigation,
  );

  return gpsLocation;
}
