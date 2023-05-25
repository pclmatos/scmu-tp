import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hotncold/pages/tools/background.dart';
import 'package:hotncold/pages/tools/header.dart';
import 'package:hotncold/providers/game_provider.dart';
import 'package:hotncold/providers/location_provider.dart';
import 'package:provider/provider.dart';

class TimeLeft extends StatefulWidget {
  const TimeLeft({super.key});

  @override
  TimeLeftState createState() => TimeLeftState();
}

class TimeLeftState extends State<TimeLeft> {
  final List<Color> colors = const [
    Color.fromARGB(255, 255, 0, 0),
    Color.fromARGB(255, 255, 60, 60),
    Color.fromARGB(255, 255, 120, 120),
    Color.fromARGB(255, 120, 120, 255),
    Color.fromARGB(255, 60, 60, 255),
    Color.fromARGB(255, 0, 0, 255),
  ];

  num calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 1000 * 12742 * asin(sqrt(a));
  }

  Timer? countdownTimer;
  Duration myDuration = const Duration(minutes: 5);
  String strDigits(int n) => n.toString().padLeft(2, '0');

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    countdownTimer =
        Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
  }

  void setCountDown() {
    const reduceSecondsBy = 1;
    setState(() {
      final seconds = myDuration.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
        countdownTimer!.cancel();
      } else {
        myDuration = Duration(seconds: seconds);
      }
    });
  }

  Color currBackgroundColor(lat1, lon1, lat2, lon2) {
    final calculatedDistance = calculateDistance(lat1, lon1, lat2, lon2);

    if (calculatedDistance >= 0 && calculatedDistance < 10) {
      return colors[0];
    } else if (calculatedDistance < 20) {
      return colors[1];
    } else if (calculatedDistance < 30) {
      return colors[2];
    } else if (calculatedDistance < 40) {
      return colors[3];
    } else if (calculatedDistance < 30) {
      return colors[4];
    } else {
      return colors[5];
    }
  }

  @override
  Widget build(BuildContext context) {
    final minutes = strDigits(myDuration.inMinutes.remainder(60));
    final seconds = strDigits(myDuration.inSeconds.remainder(60));
    final gameState = Provider.of<GameProvider>(context).state;

    return Consumer<LocationProvider>(
      builder: (context, locationProvider, child) {
        return Scaffold(
          appBar: header(context, false),
          body: Container(
            decoration: BoxDecoration(
                color: currBackgroundColor(
                    locationProvider.currentPosition.latitude,
                    locationProvider.currentPosition.longitude,
                    gameState.rounds[gameState.currentRound].latitude,
                    gameState.rounds[gameState.currentRound].longitude)),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(
                    height: 120,
                  ),
                  print('Time Left:'),
                  Text(
                    '$minutes:$seconds',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 50),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Padding print(String text) {
    return Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Text(text,
            style: const TextStyle(color: Colors.white, fontSize: 30)));
  }
}
