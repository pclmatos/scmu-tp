// ignore_for_file: unnecessary_null_comparison, avoid_print

import 'package:flutter/material.dart';
import 'package:hotncold/models/game_provider.dart';
import 'package:hotncold/models/user.dart';
import 'package:hotncold/pages/authenticate/homepage.dart';
import 'package:hotncold/pages/authenticate/login.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);
    print(user?.email);

    return ChangeNotifierProvider(
        create: (_) => GameProvider(),
        builder: (context, child) {
          if (user == null) {
            return const LoginPage();
          } else {
            return HomePage();
          }
        });
  }
}
