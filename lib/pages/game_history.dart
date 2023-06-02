// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:hotncold/models/firestore_game_entry.dart';
import 'package:hotncold/models/firestore_user.dart';
import 'package:hotncold/pages/game_info.dart';
import 'package:hotncold/pages/tools/background.dart';
import 'package:hotncold/pages/tools/header.dart';
import 'package:hotncold/services/firestore_service.dart';

class GameHistory extends StatelessWidget {
  final FirestoreUser user;

  const GameHistory({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context, true),
      body: Container(
        decoration: background(),
        child: Center(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              width: MediaQuery.of(context).size.width * 0.4,
              child: ListView.builder(
                itemCount: user.gameIds.length,
                itemBuilder: (context, index) {
                  String id = user.gameIds[index];
                  return ListTile(
                    title: SizedBox(
                      child: ElevatedButton(
                        onPressed: () async {
                          showDialog(
                              context: context,
                              builder: ((context) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }));
                          FirestoreGameEntry game =
                              await FirestoreService().getGame(id);
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => GameInfo(game: game)));
                        },
                        child: Text(
                            style: const TextStyle(
                                color: Colors.white, fontSize: 20),
                            "Game ${index + 1}"),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              child: ElevatedButton(
                child: const Text(
                    style: TextStyle(color: Colors.white, fontSize: 20),
                    "Homepage"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        )),
      ),
    );
  }
}
