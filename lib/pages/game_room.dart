// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:hotncold/models/player_entry.dart';
import 'package:hotncold/models/room_state_provider.dart';
import 'package:hotncold/models/user.dart';
import 'package:hotncold/pages/in_game/hider.dart';
import 'package:hotncold/pages/tools/header.dart';
import 'package:hotncold/pages/tools/background.dart';
import 'package:hotncold/pages/tools/server_comm.dart';
import 'package:provider/provider.dart';

class GameRoom extends StatelessWidget {
  const GameRoom({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<RoomStateProvider>(
        builder: (context, roomStateProvider, child) {
      final roomState = roomStateProvider.state;
      final MyUser user = Provider.of<MyUser>(context);

      print(roomState);
      return Scaffold(
        appBar: header(context, false),
        body: Container(
          constraints: const BoxConstraints(maxHeight: 730),
          decoration: background(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.all(20),
                child: Text(style: TextStyle(color: Colors.white), 'Players'),
              ),
              SizedBox(
                  height: 350,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20,
                    width: 200,
                    child: Text(
                        style: const TextStyle(color: Colors.white),
                        '${roomState.readyCount} out of ${roomState.players.length} players are ready!'),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Connection().closeConnection();
                      },
                      child: const Text("Leave")),
                  if (roomState
                          .containsPlayer(user.email!)
                          .compareTo("READY") !=
                      0)
                    ElevatedButton(
                        onPressed: () {
                          Connection().writeMessage('READY',
                              PlayerEntry(user.email!, "READY", "none"));
                        },
                        child: const Text("Ready"))
                ],
              )
            ],
          ),
        ),
      );
    });
  }
}
