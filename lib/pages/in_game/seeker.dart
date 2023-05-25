import 'package:flutter/material.dart';
import 'package:hotncold/pages/in_game/location_test.dart';
import 'package:hotncold/pages/in_game/time_left.dart';
import 'package:hotncold/pages/tools/header.dart';
import 'package:hotncold/pages/tools/background.dart';
import 'package:hotncold/providers/game_provider.dart';
import 'package:provider/provider.dart';

class Seeker extends StatelessWidget {
  const Seeker({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GameProvider>(
      builder: (context, gameProvider, child) {
        final gameState = gameProvider.state;

        if (gameState.rounds[gameState.currentRound].latitude != 0 &&
            gameState.rounds[gameState.currentRound].longitude != 0) {
          return const TimeLeft();
        } else {
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
                    print('You are the Seeker.'),
                    const SizedBox(
                      height: 20,
                    ),
                    print('Waiting for the Hider to hide the treasure.'),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }

  Padding print(String text) {
    return Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Text(text, style: const TextStyle(color: Colors.white)));
  }
}
