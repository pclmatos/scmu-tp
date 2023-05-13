import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

class Connection {
  late Socket socket;
  final host = "170.187.189.36";
  final port = 5000;

  void connect(String? email) async {
    socket = await Socket.connect(host, port);
    print(
        "Connecting to: ${socket.remoteAddress.address}:${socket.remotePort}");

    print(email);
    socket.add(utf8.encode(email!));

    socket.listen((Uint8List data) {
      final serverResponse = String.fromCharCodes(data);
      print(serverResponse);
    }, onError: (error) {
      print("Client: $error");
      //print("Attempting to reconnect to $host");
      socket.destroy();
      //socket = await Socket.connect(host, port);
    }, onDone: () {
      print("Client: Server left.");
      socket.destroy();
    });
  }

  closeConnection() {
    print("Closing");
    socket.destroy();
  }
}
