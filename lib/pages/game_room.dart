import 'package:flutter/material.dart';
import 'package:hotncold/models/header.dart';
import 'package:hotncold/models/background.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'package:web_socket_channel/status.dart' as status;

class GameRoom extends StatefulWidget {
  const GameRoom({super.key});
  @override
  State<StatefulWidget> createState() => _GameRoomState();
}

class _GameRoomState extends State<GameRoom> {
  final channel = WebSocketChannel.connect(
    Uri.parse('wss://170.187.189.36:8080/myApp/game'),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context, true),
      body: Container(
        decoration: background(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[],
        ),
      ),
    );
  }
}
