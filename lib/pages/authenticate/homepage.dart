// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:hotncold/pages/tools/header.dart';
import 'package:hotncold/pages/tools/background.dart';
import 'package:hotncold/pages/how_to_play.dart';
import 'package:hotncold/services/auth.dart';

class HomePage extends StatelessWidget {
  final String uid;
  final AuthService auth = AuthService();

  HomePage({super.key, required this.uid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context, false),
      body: Container(
        decoration: background(),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 75,
                width: 250,
                child: ElevatedButton(
                  child: const Text("Join Game Room",
                      style: TextStyle(fontSize: 20)),
                  onPressed: () async {},
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 75,
                width: 250,
                child: ElevatedButton(
                    child: const Text(
                      "How To Play",
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HowToPlay()));
                    }),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 75,
                width: 250,
                child: ElevatedButton(
                    child: const Text(
                      "Logout",
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () async {
                      auth.signOut();
                      Navigator.pop(context);
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
