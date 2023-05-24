// ignore_for_file: library_private_types_in_public_api

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:hotncold/pages/in_game/camera.dart';
import 'package:hotncold/pages/tools/esp_comm.dart';
import 'package:hotncold/pages/tools/header.dart';
import 'package:hotncold/pages/tools/background.dart';

class Hider extends StatefulWidget {
  const Hider({super.key});

  @override
  _HiderState createState() => _HiderState();
}

class _HiderState extends State<Hider> {
  late List<CameraDescription> cameras;

  Future<void> getCameras() async {
    cameras = await availableCameras();
  }

  @override
  void initState() {
    super.initState();
    getCameras();
    EspComm().initializeBluetooth();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController codeController = TextEditingController();
    String code = '';

    return Scaffold(
      appBar: header(context, false),
      body: Container(
        decoration: background(),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
              ),
              print('You are the Hider.'),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              print(
                  'Please hide the treasure and take a photo of its location.'),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.06,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.04,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.25,
                    child: TextFormField(
                      controller: codeController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        hintText: "Code",
                        hintStyle: TextStyle(color: Colors.white),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.075,
                    child: ElevatedButton(
                      child: const Text('Send Code'),
                      onPressed: () {
                        print(code);
                        EspComm().connectToDevice(context);
                      },
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.04,
                  ),
                  FloatingActionButton(
                      backgroundColor: Colors.black,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Camera()));
                      },
                      child: const Icon(Icons.camera_alt)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding print(String text) {
    return Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Text(text, style: const TextStyle(color: Colors.white)));
  }
}
