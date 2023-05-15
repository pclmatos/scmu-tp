// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:hotncold/models/room_state.dart';
import 'package:hotncold/pages/tools/header.dart';
import 'package:hotncold/pages/tools/background.dart';
import 'package:hotncold/pages/tools/server_comm.dart';
import 'package:provider/provider.dart';

class GameRoom extends StatelessWidget {
  const GameRoom({super.key});

  @override
  Widget build(BuildContext context) {
    var roomState = context.watch<RoomState>();

    return Scaffold(
      appBar: header(context, false),
      body: Container(
        constraints: const BoxConstraints(maxHeight: 700),
        decoration: background(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.all(20),
              child: Text(style: TextStyle(color: Colors.white), 'Players'),
            ),
            SizedBox(
                height: 500,
                child: ListView(
                  children: [
                    for (var player in roomState.players)
                      ListTile(
                        iconColor: Colors.white,
                        leading: const Icon(Icons.person),
                        title: Text(
                            style: const TextStyle(color: Colors.white),
                            player.email),
                      )
                  ],
                )),
            const SizedBox(
              height: 10,
              //child: Text(
              //    style: TextStyle(color: Colors.white),
              //    '${roomState.readyCount} out of ${roomState.players.length}'),
            ),
            ElevatedButton(
                onPressed: () {
                  Connection().closeConnection();
                },
                child: const Text("Leave"))
          ],
        ),
      ),
    );
  }
}
