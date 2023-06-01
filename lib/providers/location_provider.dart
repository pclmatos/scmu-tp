import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';

class LocationProvider extends ChangeNotifier {
  late Position _currPosition;
  late Stream<Position> _positionStream;

  LocationProvider() {
    _positionStream = Geolocator.getPositionStream(
        locationSettings:
            const LocationSettings(accuracy: LocationAccuracy.best));

    _positionStream.listen((Position position) {
      _currPosition = position;

      notifyListeners();
    });
  }

  Position get currentPosition => _currPosition;

  set state(Position newPos) {
    _currPosition = newPos;

    notifyListeners();
  }
}
