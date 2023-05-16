import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/widgets.dart';
import 'package:hotncold/messages/leave_message.dart';
import 'package:hotncold/messages/player_message.dart';
import 'package:hotncold/models/player_entry.dart';
import 'package:hotncold/models/room_state.dart';
import 'package:hotncold/models/room_state_provider.dart';
import 'package:provider/provider.dart';

class Connection {
  static final Connection instance = Connection._internal();
  late Socket socket;
  final host = "170.187.189.36";
  final port = 5000;

  factory Connection() {
    return instance;
  }

  Connection._internal();

  Future connect(String? email, BuildContext context) async {
    var gameStateProvider =
        Provider.of<RoomStateProvider>(context, listen: false);
    socket = await Socket.connect(host, port);
    print(
        "Connecting to: ${socket.remoteAddress.address}:${socket.remotePort}");
    var message = PlayerMessage("INIT", PlayerEntry(email!, 'IDLE', 'none'));

    var jsonMessage = jsonEncode(message);
    socket.write(jsonMessage);
    socket.flush();

    socket.listen((Uint8List data) {
      var json = String.fromCharCodes(data);
      print(json);
      RoomState newState = RoomState.fromJson(json);
      gameStateProvider.state = newState;
    }, onError: (error) {
      print("Client: $error");
      //print("Attempting to reconnect to $host");
      socket.destroy();
      resetRoom(gameStateProvider);
      Navigator.pop(context);
      //socket = await Socket.connect(host, port);
    }, onDone: () {
      print("Client: Server left.");
      socket.destroy();
      resetRoom(gameStateProvider);
      Navigator.pop(context);
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
        message = PlayerMessage(type, PlayerEntry.fromJson(content));
        break;
      case 'READY':
        message = PlayerMessage(type, PlayerEntry.fromJson(content));
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

  void resetRoom(var gameStateProvider) {
    RoomState newState = RoomState({}, 0);
    gameStateProvider.state = newState;
  }
}
