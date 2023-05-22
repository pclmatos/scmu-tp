import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:hotncold/pages/in_game/camera.dart';
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
              const SizedBox(
                height: 120,
              ),
              print('You are the Hider.'),
              const SizedBox(
                height: 20,
              ),
              print(
                  'Please hide the treasure and take a photo of its location.'),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Camera()));
                  },
                  child: const Text("Go to camera")),
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
