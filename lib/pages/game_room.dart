// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hotncold/models/player_entry.dart';
import 'package:hotncold/models/room_state.dart';
import 'package:hotncold/models/user.dart';
import 'package:hotncold/pages/tools/header.dart';
import 'package:hotncold/pages/tools/background.dart';
import 'package:hotncold/pages/tools/server_comm.dart';
import 'package:provider/provider.dart';

class GameRoom extends StatelessWidget {
  const GameRoom({super.key});

  @override
  Widget build(BuildContext context) {
    var roomState = context.watch<RoomState>();
    print(roomState.readyCount);

    return Scaffold(
      appBar: header(context, true),
      body: Container(
        decoration: background(),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Players"),
              ),
              SizedBox(
                height: MediaQuery.maybeDevicePixelRatioOf(context),
                child: ListView(
                  children: const [
                    //for (var player in roomState.players)
                    ListTile(leading: Icon(Icons.person), title: Text("hello"))
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () async {
                    await Connection().closeConnection();
                  },
                  child: const Text("Leave"))
            ],
          ),
        ),
      ),
    );
  }
}
