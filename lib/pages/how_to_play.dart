import 'package:flutter/material.dart';
import 'package:hotncold/models/header.dart';
import 'package:hotncold/models/background.dart';

class HowToPlay extends StatelessWidget {
  const HowToPlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context, true),
      body: Container(
        decoration: background(),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 120,
              ),
              print('1. Firstly, players should join a game room.'),
              const SizedBox(
                height: 20,
              ),
              print(
                  '2. When inside said room, the app will assign the game roles for each player. In each round there will be one hider and at least one seeker.'),
              const SizedBox(
                height: 20,
              ),
              print(
                  '3. The first one hides the system in an outdoor environment and takes a picture of the system.'),
              const SizedBox(
                height: 20,
              ),
              print(
                  '4. The seeker seeks for the system and the coordinates of the system, in conjunction with the seeker’s coordinates, will be used to grant real-time proximity updates, which will be shown, for example, with a progress bar or colors that indicate approximation or distancing.'),
              const SizedBox(
                height: 20,
              ),
              print(
                  '5. The game ends when every player plays the hider role once.'),
              const SizedBox(
                height: 20,
              ),
              print(
                  '6. At that time, the application will show to each player a leaderboard with the scores obtained by each one and a ranking. A player can obtain more or less points considering how fast he/she can find the hidden system.'),
            ],
          ),
        ),
      ),
    );
  }

  Padding print(String text) {
    return Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Text(text, style: const TextStyle(color: Colors.white)));
  }
}
