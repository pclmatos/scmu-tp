// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:hotncold/models/game_provider.dart';
import 'package:hotncold/models/player_entry.dart';
import 'package:hotncold/models/room_state_provider.dart';
import 'package:hotncold/models/user.dart';
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

      return ChangeNotifierProvider(
        create: (_) => GameProvider(),
        child: Scaffold(
          appBar: header(context, false),
          body: Container(
            constraints:
                BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
            decoration: background(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: MediaQuery.of(context).size.width * 0.1),
                      'Players'),
                ),
                SizedBox(
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: ListView(
                      children: [
                        for (var player in roomState.players)
                          ListTile(
                            iconColor: Colors.white,
                            leading: const Icon(Icons.person),
                            title: Text(
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.04),
                                '${player.email}       ${player.state}'),
                          )
                      ],
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20,
                      child: Text(
                          style: const TextStyle(color: Colors.white),
                          '${roomState.readyCount} out of ${roomState.players.length} players are ready!'),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 4,
                      child: ElevatedButton(
                          onPressed: () {
                            Connection().closeConnection();
                          },
                          child: const Text("Leave")),
                    ),
                    const SizedBox(width: 20),
                    if (roomState
                            .containsPlayer(user.email!)
                            .compareTo("READY") !=
                        0)
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 4,
                        child: ElevatedButton(
                            onPressed: () {
                              Connection().writeMessage(
                                  'READY', PlayerEntry(user.email!, "READY"));
                            },
                            child: const Text("Ready")),
                      ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
