// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:hotncold/models/player_entry.dart';
import 'package:hotncold/models/room_state.dart';
import 'package:hotncold/pages/tools/header.dart';
import 'package:hotncold/pages/tools/background.dart';
import 'package:hotncold/pages/tools/server_comm.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';

class GameRoom extends StatelessWidget {
  const GameRoom({super.key});

  @override
  Widget build(BuildContext context) {
    var roomState = context.watch<RoomState>();
    final MyUser user = Provider.of<MyUser>(context);

    return Consumer<RoomState>(builder: (context, roomState, child) {
      return Scaffold(
        appBar: header(context, false),
        body: Container(
          constraints: const BoxConstraints(maxHeight: 700),
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
                      onPressed: () async {
                        //await Connection().writeMessage('READY', PlayerEntry(user.email, 'READY'));
                      },
                      child: const Text("Ready")),
                  ElevatedButton(
                      onPressed: () {
                        Connection().closeConnection();
                      },
                      child: const Text("Leave"))
                ],
              )
            ],
          ),
        ),
      );
    });
  }
}
