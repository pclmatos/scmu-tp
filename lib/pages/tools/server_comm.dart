import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

class Connection {
  late Socket socket;

  void connect(String? email) async {
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

    socket.add(utf8.encode(email!));
  }

  /*String handleMessage(String message){
    switch(message){
      case: "Email":
        
        break;
    }
  }*/
}
