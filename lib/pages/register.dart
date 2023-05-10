import 'package:flutter/material.dart';
import 'package:hotncold/messages/messages.dart';
import 'package:hotncold/models/header.dart';
import 'package:hotncold/models/background.dart';

import 'package:http/http.dart' as http;

// ignore: use_key_in_widget_constructors
class RegisterPage extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController pwdController = TextEditingController();
  TextEditingController confirmController = TextEditingController();

  // ignore: prefer_typing_uninitialized_variables
  var name;
  // ignore: prefer_typing_uninitialized_variables
  var pwd;
  // ignore: prefer_typing_uninitialized_variables
  var confirm;

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
                child: TextFormField(
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
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 300,
                child: TextFormField(
                  obscureText: true,
                  style: const TextStyle(color: Colors.white),
                  controller: confirmController,
                  decoration: const InputDecoration(
                    hintText: "Confirm password",
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
                        child: const Text("Submit"),
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          setState(() {
                            name = nameController.text;
                            pwd = pwdController.text;
                            confirm = confirmController.text;
                          });
                          if (name == "" ||
                              pwd == "" ||
                              confirm == "" ||
                              pwd.compareTo(confirm) < 0) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content:
                                  registerMessage(context, name, pwd, confirm),
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: Colors.transparent,
                              elevation: 0,
                            ));
                          } else {
                            register(name, pwd, confirm);
                            Navigator.pop(context);
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  register(String username, String password, String confirm) async {
    const uri = 'http://170.187.189.36:8080/myApp/register';
    var map = <String, dynamic>{};

    map['username'] = username;
    map['password'] = password;
    map['confirm'] = confirm;

    http.Response response = await http.post(
      Uri.parse(uri),
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      },
      body: map,
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
