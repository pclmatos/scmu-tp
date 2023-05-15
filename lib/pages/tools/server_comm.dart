import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/widgets.dart';
import 'package:hotncold/models/room_state.dart';
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
    var gameState = Provider.of<RoomState>(context, listen: false);
    print(gameState.players);
    socket = await Socket.connect(host, port);
    print(
        "Connecting to: ${socket.remoteAddress.address}:${socket.remotePort}");
    writeMessage(email!);

    socket.listen((Uint8List data) {
      var json = String.fromCharCodes(data);
      gameState.updateRoom(json);
    }, onError: (error) {
      print("Client: $error");
      //print("Attempting to reconnect to $host");
      socket.destroy();
      Navigator.pop(context);
      //socket = await Socket.connect(host, port);
    }, onDone: () {
      print("Client: Server left.");
      socket.destroy();
      Navigator.pop(context);
    });
  }

  closeConnection() {
    print("Closing");
    socket.destroy();
  }

  writeMessage(String message) {
    socket.write(message);
    socket.flush();
  }
}
