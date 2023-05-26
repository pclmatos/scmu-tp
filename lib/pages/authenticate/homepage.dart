// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:hotncold/models/user.dart';
import 'package:hotncold/pages/game_room.dart';
import 'package:hotncold/pages/in_game/time_left.dart';
import 'package:hotncold/pages/tools/header.dart';
import 'package:hotncold/pages/tools/background.dart';
import 'package:hotncold/pages/wrapper.dart';
import 'package:hotncold/services/auth.dart';
import 'package:hotncold/pages/tools/server_comm.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  final AuthService auth = AuthService();

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final MyUser user = Provider.of<MyUser>(context);

    return Scaffold(
      appBar: header(context, false),
      body: Container(
        decoration: background(),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
                width: MediaQuery.of(context).size.width * 0.7,
                child: ElevatedButton(
                  child: Text("Join Game Room",
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.06)),
                  onPressed: () async {
                    showDialog(
                        context: context,
                        builder: ((context) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }));
                    await Connection().connect(user.email, context);
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const GameRoom()));
                  },
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
                width: MediaQuery.of(context).size.width * 0.7,
                child: ElevatedButton(
                    child: Text(
                      "How To Play",
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.06),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const TimeLeft()));
                    }),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
                width: MediaQuery.of(context).size.width * 0.7,
                child: ElevatedButton(
                    child: Text(
                      "Logout",
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.06),
                    ),
                    onPressed: () async {
                      auth.signOut();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Wrapper()));
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
