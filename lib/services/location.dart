import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';

class LocationService {
  void initService() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return Future.error('Location services are disabled');
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      Location loc = Location();
      bool isOn = await loc.serviceEnabled();

      if (!isOn) {
        await loc.requestService();
      }

      return;
    } catch (e) {
      print('Error getting location: $e');
      return;
    }
  }

  Future<Position> getCurrentLocation() async {
    final position = await Geolocator.getCurrentPosition();

    return position;
  }
}
