// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'dart:io';
import 'dart:typed_data';

import 'package:hotncold/pages/in_game/hider_waiting.dart';
import 'package:hotncold/providers/game_provider.dart';
import 'package:image/image.dart' as img;

import 'package:hotncold/models/code_entry.dart';
import 'package:hotncold/pages/tools/server_comm.dart';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hotncold/models/photo_entry.dart';
import 'package:hotncold/pages/tools/header.dart';
import 'package:hotncold/pages/tools/background.dart';
import 'package:hotncold/services/location.dart';
import 'package:provider/provider.dart';

class Hider extends StatefulWidget {
  const Hider({super.key});

  @override
  _HiderState createState() => _HiderState();
}

class _HiderState extends State<Hider> {
  late List<CameraDescription> cameras;
  TextEditingController codeController = TextEditingController();
  late PhotoEntry photoEntry;
  late CodeEntry codeEntry;
  late Position position;

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
    LocationService().initService();

    return Consumer<GameProvider>(
      builder: (context, gameProvider, child) {
        final gameState = gameProvider.state;

        if (gameState.rounds[gameState.currentRound].latitude != 0 &&
            gameState.rounds[gameState.currentRound].longitude != 0) {
          return const HiderWaiting();
        } else {
          return Scaffold(
            appBar: header(context, false),
            resizeToAvoidBottomInset: false,
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
                    // Center(
                    //   child: FloatingActionButton(
                    //       backgroundColor: Colors.black,
                    //       onPressed: () async {
                    //         XFile photo = await Navigator.push(
                    //             context,
                    //             MaterialPageRoute(
                    //                 builder: (context) => const Camera()));

                    //         await Navigator.push(
                    //             context,
                    //             MaterialPageRoute(
                    //                 builder: ((context) =>
                    //                     DisplayPictureScreen(image: photo))));
                    //         position = await LocationService().getCurrentLocation();

                    //         final resizedImage = await resizeImage(photo, 288, 352);
                    //         print(resizedImage.lengthInBytes);

                    //         photoEntry = PhotoEntry(resizedImage);
                    //       },
                    //       child: const Icon(Icons.camera_alt)),
                    // ),
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
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
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
                              onPressed: () async {
                                FocusScope.of(context).unfocus();
                                position = await LocationService()
                                    .getCurrentLocation();
                                setState(() {
                                  code = codeController.text;
                                });

                                if (isNumeric(code) && code.length == 4) {
                                  codeEntry = CodeEntry(code, position.latitude,
                                      position.longitude);
                                  Connection().writeMessage('CODE', codeEntry);
                                } else {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Invalid Code'),
                                        content: const Text(
                                            'The code must be a 4 digit number!'),
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
                                }
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
      },
    );
  }

  Padding print1(String text) {
    return Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Text(text, style: const TextStyle(color: Colors.white)));
  }

  bool isNumeric(String input) {
    final numeric = num.tryParse(input);
    return numeric != null;
  }

  Future<Uint8List> resizeImage(XFile imageFile, int width, int height) async {
    // Read the image file
    Uint8List imageBytes = await imageFile.readAsBytes();

    // Decode the image
    img.Image? image = img.decodeImage(imageBytes);

    // Resize the image
    img.Image resizedImage =
        img.copyResize(image!, width: width, height: height);

    // Encode the resized image to bytes
    Uint8List resizedBytes =
        img.encodeJpg(resizedImage); // or encodePng if you prefer PNG format

    return resizedBytes;
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
