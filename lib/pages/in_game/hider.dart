// ignore_for_file: library_private_types_in_public_api

import 'dart:convert';
import 'dart:io';

import 'package:hotncold/pages/tools/server_comm.dart';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hotncold/models/photo_entry.dart';
import 'package:hotncold/pages/in_game/camera.dart';
import 'package:hotncold/pages/tools/header.dart';
import 'package:hotncold/pages/tools/background.dart';
import 'package:hotncold/services/location.dart';

class Hider extends StatefulWidget {
  const Hider({super.key});

  @override
  _HiderState createState() => _HiderState();
}

class _HiderState extends State<Hider> {
  late List<CameraDescription> cameras;
  TextEditingController codeController = TextEditingController();

  String code = '';

  Future<void> getCameras() async {
    cameras = await availableCameras();
  }

  @override
  void initState() {
    super.initState();
    getCameras();
  }

  @override
  Widget build(BuildContext context) {
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
              print1('You are the Hider.'),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              print1(
                  'Please hide the treasure and take a photo of its location.'),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              print1(
                  'After that use the hider card on the RFID reader of the treasure and input the displayed code in the box. Finally press the "Send Code" button to send the code to the server.'),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.06,
              ),
              Center(
                child: FloatingActionButton(
                    backgroundColor: Colors.black,
                    onPressed: () async {
                      XFile photo = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Camera()));

                      Position position =
                          await LocationService().getCurrentLocation();

                      final bytes = await photo.readAsBytes();

                      PhotoEntry entry = PhotoEntry(
                          position.latitude, position.longitude, bytes);

                      print(base64Encode(bytes));
                      print(entry.toJson());
                      // ignore: use_build_context_synchronously
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) =>
                                  DisplayPictureScreen(image: photo))));
                    },
                    child: const Icon(Icons.camera_alt)),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.07),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.05,
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
                      width: MediaQuery.of(context).size.width * 0.04,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.07,
                      child: ElevatedButton(
                        child: const Text('Send Code'),
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          setState(() {
                            code = codeController.text;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding print1(String text) {
    return Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Text(text, style: const TextStyle(color: Colors.white)));
  }
}

class DisplayPictureScreen extends StatelessWidget {
  final XFile image;

  const DisplayPictureScreen({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context, true),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Image.file(File(image.path)),
    );
  }
}
