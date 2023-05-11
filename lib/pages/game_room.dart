import 'package:flutter/material.dart';
import 'package:hotncold/pages/tools/header.dart';
import 'package:hotncold/pages/tools/background.dart';

class GameRoom extends StatefulWidget {
  const GameRoom({super.key});
  @override
  State<StatefulWidget> createState() => _GameRoomState();
}

class _GameRoomState extends State<GameRoom> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context, true),
      body: Container(
        decoration: background(),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[],
        ),
      ),
    );
  }
}
