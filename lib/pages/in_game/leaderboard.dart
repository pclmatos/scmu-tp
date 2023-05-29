import 'package:flutter/material.dart';
import 'package:hotncold/models/score.dart';
import 'package:hotncold/pages/tools/server_comm.dart';
import 'package:hotncold/providers/game_provider.dart';
import 'package:hotncold/pages/tools/background.dart';
import 'package:hotncold/pages/tools/header.dart';
import 'package:provider/provider.dart';

class Leaderboard extends StatelessWidget {
  const Leaderboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GameProvider>(builder: (context, game, child) {
      final scores = game.state.scores;

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
                  height: MediaQuery.of(context).size.height * 0.05,
                  child: Text(
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: MediaQuery.of(context).size.width * 0.1),
                      'Leaderboard')),
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
                        'Leave'),
                    onPressed: () {
                      Connection().closeConnection();
                    },
                  ))
            ],
          )),
        ),
      );
    });
  }
}
