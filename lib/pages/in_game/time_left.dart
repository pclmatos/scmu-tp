import 'package:flutter/material.dart';
import 'package:hotncold/pages/tools/background.dart';
import 'package:hotncold/pages/tools/header.dart';
import 'package:hotncold/providers/game_provider.dart';
import 'package:hotncold/providers/location_provider.dart';
import 'package:provider/provider.dart';

class TimeLeft extends StatelessWidget {
  const TimeLeft({super.key});

  @override
  Widget build(BuildContext context) {
    final gameState = Provider.of<GameProvider>(context);

    return Consumer<LocationProvider>(
      builder: (context, locationProvider, child) {
        final location = locationProvider.currentPosition;
        return Scaffold(
          appBar: header(context, false),
          body: Container(
            decoration: background(),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(
                    height: 120,
                  ),
                  print('Time Left:')
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
