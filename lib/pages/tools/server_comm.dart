import 'dart:io';
import 'dart:typed_data';

class Connection {
  void connect() async {
    final socket = await Socket.connect("170.187.189.36", 5000);
    print("Connected to: ${socket.remoteAddress.address}:${socket.remotePort}");

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

    //socket.add(data)
  }
}
