// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:hotncold/providers/location_provider.dart';
import 'package:provider/provider.dart';

class LocationApp extends StatelessWidget {
  const LocationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LocationProvider>(builder: (context, locationProvider, _) {
      final location = locationProvider.currentPosition;

      return Scaffold(
        appBar: AppBar(
          title: const Text('Location App'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Latitude: ${location != null ? location.latitude.toStringAsFixed(6) : 'N/A'}',
              ),
              Text(
                'Longitude: ${location != null ? location.longitude.toStringAsFixed(6) : 'N/A'}',
              )
            ],
          ),
        ),
      );
    });
  }
}
