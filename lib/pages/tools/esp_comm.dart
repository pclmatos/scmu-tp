import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:permission_handler/permission_handler.dart';

class EspComm {
  static final EspComm _instance = EspComm._internal();

  BluetoothConnection? _connection;
  bool _isConnected = false;

  factory EspComm() {
    return _instance;
  }

  EspComm._internal();

  void initializeBluetooth() async {
    BluetoothState state = await FlutterBluetoothSerial.instance.state;
    requestBluetoothPermissions();

    if (state.isEnabled) {
      return;
      // Bluetooth is available, continue with your logic
    } else {
      // Bluetooth is not enabled, you can request the user to enable it
      FlutterBluetoothSerial.instance.requestEnable();
      return;
    }
  }

  // Rest of the class implementation...

  Future<void> connectToDevice(BuildContext context) async {
    BluetoothDevice? device = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const BluetoothDeviceList(),
      ),
    );
    _connection = await BluetoothConnection.toAddress(device?.address);
    _isConnected = true;

    _connection!.input?.listen((Uint8List data) {
      // Handle received data
      String message = String.fromCharCodes(data);
      print('Received: $message');
    });
  }

  void requestBluetoothPermissions() async {
    PermissionStatus status = await Permission.bluetooth.request();
    if (status.isDenied) {
      Permission.bluetooth.request();
    } else if (status.isPermanentlyDenied) {
      // Permissions are permanently denied. Open app settings.
      openAppSettings();
    } else if (status.isGranted) {
      // Permissions are granted. Proceed with Bluetooth operations.
      // Your Bluetooth code here.
    }
  }

  void sendMessage(String message) {
    if (_isConnected && _connection != null) {
      _connection!.output.add(Uint8List.fromList(utf8.encode(message)));
      _connection!.output.allSent.then((_) {
        print('Sent: $message');
      });
    }
  }

  void disconnect() {
    if (_isConnected && _connection != null) {
      _isConnected = false;
      _connection!.dispose();
      _connection = null;
    }
  }
}

class BluetoothDeviceList extends StatefulWidget {
  const BluetoothDeviceList({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BluetoothDeviceListState createState() => _BluetoothDeviceListState();
}

class _BluetoothDeviceListState extends State<BluetoothDeviceList> {
  List<BluetoothDevice> devices = [];

  @override
  void initState() {
    super.initState();
    _getPairedDevices();
  }

  void _getPairedDevices() async {
    EspComm().initializeBluetooth();
    devices = await FlutterBluetoothSerial.instance.getBondedDevices();

    devices.forEach((device) {
      print('Device: ${device.name}, address: ${device.address}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Device'),
      ),
      body: ListView.builder(
        itemCount: devices.length,
        itemBuilder: (context, index) {
          BluetoothDevice device = devices[index];
          print(devices[index].name);
          return ListTile(
            title: Text(device.name!),
            subtitle: Text(device.address),
            onTap: () {
              Navigator.pop(context, device);
            },
          );
        },
      ),
    );
  }
}
