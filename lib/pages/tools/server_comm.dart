import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:hotncold/models/user.dart';

class Connection {
  late Socket socket;

  void connect(MyUser? user) async {
    socket = await Socket.connect("170.187.189.36", 5000);
    print(
        "Connecting to: ${socket.remoteAddress.address}:${socket.remotePort}");

    socket.listen((Uint8List data) {
      final serverResponse = String.fromCharCodes(data);
      print("Client $serverResponse");
    }, onError: (error) {
      print("Client: $error");
      socket.destroy();
    }, onDone: () {
      print("Client: Server left.");
      socket.destroy();
    });

    socket.add(utf8.encode(user.toString()));
  }

  /*String handleMessage(String message){
    switch(message){
      case: "Email":
        
        break;
    }
  }*/
}
