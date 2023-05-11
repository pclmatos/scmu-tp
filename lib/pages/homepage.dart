import 'package:flutter/material.dart';
import 'package:hotncold/models/header.dart';
import 'package:hotncold/models/background.dart';
import 'package:http/http.dart' as http;

import 'how_to_play.dart';

class HomePage extends StatefulWidget {
  final String username;

  const HomePage({Key? key, required this.username}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                      await logout();
                      // ignore: use_build_context_synchronously
                      Navigator.pop(context);
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  logout() async {
    const uri = 'http://170.187.189.36:8080/myApp/logout';

    var map = <String, dynamic>{};
    map["username"] = widget.username;

    http.Response response = await http.post(
      Uri.parse(uri),
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      },
      body: map,
    );
  }
}
