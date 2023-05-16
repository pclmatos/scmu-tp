import 'package:flutter/material.dart';
import 'package:hotncold/models/user.dart';
import 'package:hotncold/pages/in_game/seeker.dart';
import 'package:hotncold/pages/in_game/hider.dart';
import 'package:provider/provider.dart';

class RoleWrapper extends StatelessWidget {
  const RoleWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);
    print(user?.email);

    if (user == null) {
      return const Seeker();
    } else {
      return const Hider();
    }
  }
}
