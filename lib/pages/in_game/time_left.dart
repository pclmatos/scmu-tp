import 'package:flutter/material.dart';
import 'package:hotncold/pages/tools/background.dart';
import 'package:hotncold/pages/tools/header.dart';

class TimeLeft extends StatelessWidget {
  const TimeLeft({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context, true),
      body: Container(
        decoration: background(),
        child: const Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 120,
              ),
              print('Time Left:')
            ],
          ),
        ),
      ),
    );
  }

  Padding print(String text) {
    return Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Text(text,
            style: const TextStyle(color: Colors.white, fontSize: 30)));
  }
}
