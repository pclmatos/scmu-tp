// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hotncold/models/game_provider.dart';
import 'package:hotncold/models/user.dart';
import 'package:hotncold/pages/game_room.dart';
import 'package:hotncold/pages/in_game/leaderboard.dart';
import 'package:hotncold/pages/in_game/players_finished.dart';
import 'package:hotncold/pages/tools/header.dart';
import 'package:hotncold/pages/tools/background.dart';
import 'package:hotncold/pages/how_to_play.dart';
import 'package:hotncold/pages/wrapper.dart';
import 'package:hotncold/services/auth.dart';
import 'package:hotncold/pages/tools/server_comm.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  final AuthService auth = AuthService();

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final MyUser user = Provider.of<MyUser>(context);

    return Provider<GameProvider>(
      create: (_) => GameProvider(),
      child: Scaffold(
        appBar: header(context, false),
        body: Container(
          decoration: background(),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 75,
                  width: 250,
                  child: ElevatedButton(
                    child: const Text("Join Game Room",
                        style: TextStyle(fontSize: 20)),
                    onPressed: () async {
                      await Connection().connect(user.email, context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const GameRoom()));
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 75,
                  width: 250,
                  child: ElevatedButton(
                      child: const Text(
                        "How To Play",
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const PlayersFinished()));
                      }),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 75,
                  width: 250,
                  child: ElevatedButton(
                      child: const Text(
                        "Logout",
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () async {
                        auth.signOut();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Wrapper()));
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
