import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hotncold/models/header.dart';
import 'package:hotncold/models/background.dart';
import 'package:http/http.dart';

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
                width: 200,
                child: ElevatedButton(
                  child: const Text("Join Game Room"),
                  onPressed: () {},
                ),
              ),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  child: const Text("How to play"),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
