import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hotncold/models/header.dart';
import 'package:hotncold/models/background.dart';
import 'package:http/http.dart';

import 'how_to_play.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context),
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
                  onPressed: () {},
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
            ],
          ),
        ),
      ),
    );
  }
}
