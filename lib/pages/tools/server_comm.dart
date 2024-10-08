import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:hotncold/messages/confirmation_message.dart';
import 'package:hotncold/messages/leave_message.dart';
import 'package:hotncold/messages/message.dart';
import 'package:hotncold/messages/code_message.dart';
import 'package:hotncold/messages/photo_message.dart';
import 'package:hotncold/messages/player_message.dart';
import 'package:hotncold/messages/start_message.dart';
import 'package:hotncold/messages/state_message.dart';
import 'package:hotncold/models/game.dart';
import 'package:hotncold/pages/in_game/leaderboard.dart';
import 'package:hotncold/providers/game_provider.dart';
import 'package:hotncold/models/player_entry.dart';
import 'package:hotncold/models/room_state.dart';
import 'package:hotncold/providers/room_state_provider.dart';
import 'package:hotncold/pages/in_game/role_wrapper.dart';
import 'package:hotncold/pages/wrapper.dart';
import 'package:provider/provider.dart';

class Connection {
  static final Connection instance = Connection._internal();
  late Socket socket;
  final host = "170.187.189.36";
  final port = 5000;
  late RoomStateProvider roomStateProvider;
  late GameProvider gameProvider;

  factory Connection() {
    return instance;
  }

  Connection._internal();

  Future connect(String? email, BuildContext context) async {
    roomStateProvider = Provider.of<RoomStateProvider>(context, listen: false);
    gameProvider = Provider.of<GameProvider>(context, listen: false);

    socket = await Socket.connect(host, port);
    print(
        "Connecting to: ${socket.remoteAddress.address}:${socket.remotePort}");

    writeMessage("INIT", PlayerEntry(email!, 'IDLE'));

    socket.listen((Uint8List data) {
      var json = String.fromCharCodes(data);
      handleMessage(json, context);
    }, onError: (error) {
      print("Client: $error");
      //print("Attempting to reconnect to $host");
      socket.destroy();
      resetGameRoom(context);
      //socket = await Socket.connect(host, port);
    }, onDone: () {
      print("Client: Server left.");
      socket.destroy();
      resetGameRoom(context);
    });
  }

  closeConnection() {
    print("Closing");
    writeMessage('LEAVE', '');
    socket.destroy();
  }

  writeMessage(String type, dynamic content) {
    var message;
    switch (type) {
      case 'INIT':
        message = PlayerMessage(type, content);
        break;
      case 'READY':
        message = PlayerMessage(type, content);
        break;
      case 'PHOTO':
        message = PhotoMessage(type, content);
        break;
      case 'CODE':
        message = CodeMessage(type, content);
        break;
      case 'CONFIRMATION':
        message = ConfirmationMessage(type, content);
        break;
      case 'LEAVE':
        message = LeaveMessage(type);
        break;
      default:
        break;
    }

    var toSend = jsonEncode(message);
    socket.write(toSend);
    socket.flush();
  }

  void resetProvider(dynamic provider) {
    if (provider is RoomStateProvider) {
      RoomState newState = RoomState([], 0);
      provider.state = newState;
    } else if (provider is GameProvider) {
      provider.state = Game([], 0, []);
    }
  }

  void handleMessage(dynamic json, BuildContext context) {
    Message tmp = Message.fromJson(json);
    print(json);
    switch (tmp.type) {
      case "STATE":
        StateMessage msg = StateMessage.fromJson(json);
        roomStateProvider.state = msg.content;
        break;
      case 'START':
        StartMessage msg = StartMessage.fromJson(json);
        // gameProvider = Provider.of<GameProvider>(context, listen: false);
        gameProvider.state = msg.game;
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const RoleWrapper()));
        break;
      case 'WRONG':
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Wrong Code'),
              content: const Text(
                  'The confimation code provided is wrong. Please try again.'),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
        break;
      case 'FINISH':
        StartMessage msg = StartMessage.fromJson(json);
        // gameProvider = Provider.of<GameProvider>(context, listen: false);
        gameProvider.state = msg.game;
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const Leaderboard()));
        break;
      default:
        break;
    }
  }

  void resetGameRoom(BuildContext context) {
    resetProvider(roomStateProvider);
    resetProvider(gameProvider);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Wrapper()));
  }
}
