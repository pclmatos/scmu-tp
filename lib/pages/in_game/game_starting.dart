import 'package:flutter/material.dart';
import 'package:hotncold/pages/tools/header.dart';
import 'package:hotncold/pages/tools/background.dart';

class GameStarting extends StatelessWidget {
  const GameStarting({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context, true),
      body: Container(
        decoration: background(),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 120,
              ),
              print('The Hider has hiden the treasure.'),
              const SizedBox(
                height: 20,
              ),
              print(
                  'You have 5 minutes to find it and to use your RFID tag on the reader.'),
              const SizedBox(
                height: 20,
              ),
              print('Good luck!.'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                      onPressed: () {
                        //Navigator.push(context,
                        //MaterialPageRoute(builder: (context) => ));
                        //await Connection().writeMessage('READY', PlayerEntry(user.email, 'READY'));
                      },
                      child: const Text("Ready?")),
                ],
              )
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
