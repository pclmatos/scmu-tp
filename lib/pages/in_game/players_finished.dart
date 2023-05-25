import 'package:flutter/material.dart';
import 'package:hotncold/pages/tools/background.dart';
import 'package:hotncold/pages/tools/header.dart';

class PlayersFinished extends StatelessWidget {
  const PlayersFinished({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context, true),
      body: Container(
        decoration: background(),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                height: 60,
              ),
              print1(
                  'Congratulations! You found the treasure in x:yz minutes.'),
              const SizedBox(
                height: 120,
              ),
              print2('x/y players finished'),
              const SizedBox(
                height: 120,
              ),
              print2('Waiting for other players to finish...')
            ],
          ),
        ),
      ),
    );
  }

  Padding print1(String text) {
    return Padding(
        padding: const EdgeInsets.only(left: 13, right: 0),
        child: Text(text,
            style: const TextStyle(color: Colors.white, fontSize: 30)));
  }

  Padding print2(String text) {
    return Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Text(text,
            style: const TextStyle(color: Colors.white, fontSize: 25)));
  }
}
