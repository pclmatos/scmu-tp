import 'package:flutter/material.dart';
import 'package:hotncold/models/room_state_provider.dart';
import 'package:hotncold/pages/tools/background.dart';
import 'package:hotncold/pages/tools/header.dart';
import 'package:provider/provider.dart';

class Leaderboard extends StatelessWidget {
  const Leaderboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<RoomStateProvider>(
        builder: (context, roomStateProvider, child) {
      final roomState = roomStateProvider.state;

      Padding print(String text) {
        return Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Text(text,
                style: const TextStyle(color: Colors.white, fontSize: 30)));
      }

      return Scaffold(
        appBar: header(context, true),
        body: Container(
          decoration: background(),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(
                  height: 60,
                ),
                print('Leaderboard'),
                const SizedBox(
                  height: 60,
                ),
                print('Winner'),
                const SizedBox(
                  height: 100,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    print('2nd Place'),
                    const SizedBox(
                      width: 30,
                    ),
                    print('3rd Place')
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
