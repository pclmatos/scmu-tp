// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:hotncold/messages/errors.dart';
import 'package:hotncold/pages/tools/header.dart';
import 'package:hotncold/pages/tools/background.dart';
import 'package:hotncold/pages/wrapper.dart';
import 'package:hotncold/services/auth.dart';

// ignore: use_key_in_widget_constructors
class RegisterPage extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<RegisterPage> {
  final AuthService auth = AuthService();

  TextEditingController emailController = TextEditingController();
  TextEditingController pwdController = TextEditingController();
  TextEditingController confirmController = TextEditingController();

  String email = '';
  String pwd = '';
  String confirm = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context, true),
      body: Container(
        decoration: background(),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: TextFormField(
                  controller: emailController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    hintText: "Email",
                    hintStyle: TextStyle(color: Colors.white),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: TextFormField(
                  controller: pwdController,
                  obscureText: true,
                  style: const TextStyle(color: Colors.white),
                  onChanged: (val) {
                    setState(() {
                      pwd = val;
                    });
                  },
                  decoration: const InputDecoration(
                    hintText: "Password",
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
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: TextFormField(
                  controller: confirmController,
                  obscureText: true,
                  style: const TextStyle(color: Colors.white),
                  onChanged: (val) {
                    setState(() {
                      confirm = val;
                    });
                  },
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
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: ElevatedButton(
                          child: const Text("Submit"),
                          onPressed: () async {
                            FocusScope.of(context).unfocus();
                            setState(() {
                              email = emailController.text;
                              pwd = pwdController.text;
                              confirm = confirmController.text;
                            });
                            if (validateCredentials(email, pwd, confirm)) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: registerMessage(
                                    context, email, pwd, confirm),
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Colors.transparent,
                                elevation: 0,
                              ));
                            } else {
                              dynamic result = await auth
                                  .registerWithEmailAnPassword(email, pwd);
                              if (result == null) {
                                setState(() {
                                  error = 'Please provide a valid email';
                                });
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(error),
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: Colors.transparent,
                                  elevation: 0,
                                ));
                              } else {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const Wrapper(),
                                    ));
                              }
                            }
                          },
                        ),
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

  bool validateCredentials(String email, String pwd, String confirm) {
    return email == "" ||
        pwd == "" ||
        confirm == "" ||
        pwd.compareTo(confirm) != 0;
  }
}
