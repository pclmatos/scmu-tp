import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:hotncold/pages/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Hot n' Cold",
      home: LoginPage(),
    );
  }
}
