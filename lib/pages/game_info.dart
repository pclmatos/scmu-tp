import 'package:flutter/material.dart';
import 'package:hotncold/models/firestore_game_entry.dart';
import 'package:hotncold/models/score.dart';
import 'package:hotncold/pages/tools/background.dart';
import 'package:hotncold/pages/tools/header.dart';

class GameInfo extends StatelessWidget {
  final FirestoreGameEntry game;

  const GameInfo({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    List<Score> scores = game.game.scores;

    return Scaffold(
      appBar: header(context, false),
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: background(),
        child: Center(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                height: MediaQuery.of(context).size.height * 0.6,
                child: ListView.builder(
                    itemCount: scores.length,
                    itemBuilder: (context, index) {
                      Score score = scores[index];
                      return ListTile(
                        title: Text(
                            style: TextStyle(
                                color: Colors.white,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.05),
                            '${index + 1}.  ${score.email}  -  ${score.score} points'),
                      );
                    })),
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.2,
                child: ElevatedButton(
                  child: Text(
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: MediaQuery.of(context).size.width * 0.04),
                      'History'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ))
          ],
        )),
      ),
    );
  }
}
