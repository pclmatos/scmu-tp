import 'package:flutter/material.dart';
import 'package:hotncold/pages/tools/background.dart';
import 'package:hotncold/pages/tools/header.dart';

class HiderWaiting extends StatelessWidget {
  const HiderWaiting({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context, false),
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: background(),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: MediaQuery.of(context).size.width * 0.06),
                  'Waiting for seekers to finish this round.'),
              Text(
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: MediaQuery.of(context).size.width * 0.06),
                  'Please wait.'),
            ],
          ),
        ),
      ),
    );
  }
}
