import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hotncold/models/confirmation_entry.dart';
import 'package:hotncold/pages/in_game/players_finished.dart';
import 'package:hotncold/pages/tools/header.dart';
import 'package:hotncold/pages/tools/server_comm.dart';
import 'package:hotncold/providers/game_provider.dart';
import 'package:hotncold/providers/location_provider.dart';
import 'package:provider/provider.dart';

class TimeLeft extends StatefulWidget {
  const TimeLeft({super.key});

  @override
  TimeLeftState createState() => TimeLeftState();
}

class TimeLeftState extends State<TimeLeft> {
  late num calculatedDistance;
  String confirmationCode = 'NONE';
  TextEditingController codeController = TextEditingController();

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
  Duration myDuration = const Duration(minutes: 1);
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
        countdownTimer?.cancel();
      } else {
        myDuration = Duration(seconds: seconds);
      }
    });
  }

  Color currBackgroundColor(lat1, lon1, lat2, lon2) {
    calculatedDistance = calculateDistance(lat1, lon1, lat2, lon2);

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

  Row inputConfirmationCode(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.25,
          child: TextFormField(
              controller: codeController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                  hintText: "Code",
                  hintStyle: TextStyle(color: Colors.white),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)))),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.04,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.07,
          child: ElevatedButton(
            child: const Text('Send Code'),
            onPressed: () async {
              FocusScope.of(context).unfocus();
              setState(() {
                confirmationCode = codeController.text;
              });

              ConfirmationEntry entry =
                  ConfirmationEntry(confirmationCode, countdownTimer!.tick);
              Connection().writeMessage('CONFIRMATION', entry);
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final minutes = strDigits(myDuration.inMinutes.remainder(60));
    final seconds = strDigits(myDuration.inSeconds.remainder(60));
    final gameState = Provider.of<GameProvider>(context).state;

    return Consumer<LocationProvider>(
        builder: (context, locationProvider, child) {
      final currentPosition = locationProvider.currentPosition;

      if (countdownTimer!.isActive) {
        return Scaffold(
          appBar: header(context, false),
          resizeToAvoidBottomInset: false,
          body: Container(
            decoration: BoxDecoration(
                color: currBackgroundColor(
                    currentPosition.latitude,
                    currentPosition.longitude,
                    gameState.rounds[gameState.currentRound].latitude,
                    gameState.rounds[gameState.currentRound].longitude)),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  print1('Time Left:'),
                  Text(
                    '$minutes:$seconds',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 50),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.2,
                  ),
                  Text(
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.05,
                          color: Colors.white),
                      'Distance to treasure'),
                  Text(
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.05,
                          color: Colors.white),
                      '${calculatedDistance.toStringAsFixed(2)} m'),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  // if (calculatedDistance <= 10)
                  inputConfirmationCode(context)
                ],
              ),
            ),
          ),
        );
      } else {
        Connection().writeMessage('CONFIRMATION',
            ConfirmationEntry(confirmationCode, countdownTimer!.tick));

        return PlayersFinished(duration: myDuration);
      }
    });
  }
}

Padding print1(String text) {
  return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Text(text,
          style: const TextStyle(color: Colors.white, fontSize: 30)));
}
