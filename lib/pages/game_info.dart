import 'package:flutter/material.dart';
import 'package:hotncold/models/firestore_game_entry.dart';
import 'package:hotncold/models/round.dart';
import 'package:hotncold/pages/scoreboard.dart';
import 'package:hotncold/pages/tools/background.dart';
import 'package:hotncold/pages/tools/header.dart';

class GameInfo extends StatelessWidget {
  final FirestoreGameEntry game;

  const GameInfo({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    List<Round> rounds = game.game.rounds;

    return Scaffold(
      appBar: header(context, true),
      body: Container(
        decoration: background(),
        child: Center(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
                height: MediaQuery.of(context).size.height * 0.8,
                child: ListView.builder(
                  itemCount: rounds.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 40),
                                'Round ${index + 1}'),
                          ],
                        ),
                        SizedBox(
                          child: Text(
                            style: const TextStyle(
                                color: Colors.white, fontSize: 20),
                            "Hider: ${rounds[index].hider.email}",
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        const Text(
                          style: TextStyle(color: Colors.white, fontSize: 20),
                          "Seekers:",
                        ),
                        for (var entry in rounds[index].seekers)
                          Text(
                            style: const TextStyle(
                                color: Colors.white, fontSize: 20),
                            entry.email,
                          ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03,
                        ),
                      ],
                    );
                  },
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: ElevatedButton(
                      child: Text(
                          style: TextStyle(
                              color: Colors.white,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.04),
                          'History'),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.05,
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: ElevatedButton(
                      child: Text(
                          style: TextStyle(
                              color: Colors.white,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.04),
                          'Scoreboard'),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    Scoreboard(scores: game.game.scores)));
                      },
                    )),
              ],
            )
          ],
        )),
      ),
    );
  }
}
