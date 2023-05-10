import 'package:flutter/material.dart';
import 'package:hotncold/messages/messages.dart';
import 'package:hotncold/models/header.dart';
import 'package:hotncold/models/background.dart';
import 'package:hotncold/pages/homepage.dart';
import 'package:hotncold/pages/register.dart';

import 'package:http/http.dart' as http;

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
  // ignore: prefer_typing_uninitialized_variables
  var result;

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
                  obscureText: true,
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
                      SizedBox(
                        width: 90,
                        child: ElevatedButton(
                          child: const Text("Login"),
                          onPressed: () async {
                            FocusScope.of(context).unfocus();
                            setState(() {
                              name = nameController.text;
                              pwd = pwdController.text;
                            });
                            if (name == "" || pwd == "") {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: loginMessage(context, name, pwd),
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Colors.transparent,
                                elevation: 0,
                              ));
                            } else {
                              await login(name, pwd);
                              if (result == 200) {
                                // ignore: use_build_context_synchronously
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomePage(
                                              username: name,
                                            )));
                              }
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(children: [
                    SizedBox(
                      width: 90,
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RegisterPage()));
                          },
                          child: const Text("Register")),
                    ),
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

  login(String username, String password) async {
    const uri = 'http://170.187.189.36:8080/myApp/login';
    var map = <String, dynamic>{};

    map['username'] = username;
    map['password'] = password;

    http.Response response = await http.post(
      Uri.parse(uri),
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      },
      body: map,
    );

    setState(
      () {
        result = response.statusCode;
      },
    );
    if (response.statusCode == 400) {
      // ignore: use_build_context_synchronously
      return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: postError(response.body),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ));
    }
  }
}
