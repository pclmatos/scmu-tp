import 'package:flutter/material.dart';
import 'package:hotncold/header.dart';

// ignore: use_key_in_widget_constructors
class LoginPage extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController pwdController = TextEditingController();

  // ignore: prefer_typing_uninitialized_variables
  var name;
  // ignore: prefer_typing_uninitialized_variables
  var pwd;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context),
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 44, 124, 228),
                  Color.fromARGB(255, 201, 42, 31)
                ],
                begin: FractionalOffset.centerLeft,
                end: FractionalOffset.centerRight,
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp)),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 300,
                child: TextField(
                  style: const TextStyle(color: Colors.white),
                  controller: nameController,
                  decoration: const InputDecoration(
                    hintText: "Enter your name",
                    hintStyle: TextStyle(color: Colors.white),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 300,
                child: TextField(
                  style: const TextStyle(color: Colors.white),
                  controller: pwdController,
                  decoration: const InputDecoration(
                    hintText: "Enter your password",
                    hintStyle: TextStyle(
                      color: Colors.white,
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      ElevatedButton(
                        child: const Text("Login"),
                        onPressed: () {
                          setState(() {
                            name = nameController.text;
                            pwd = pwdController.text;
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(children: [
                    ElevatedButton(
                        onPressed: () {}, child: const Text("Register")),
                  ])
                ],
              ),
              const Text(
                "Please register if you don't have an account.",
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
