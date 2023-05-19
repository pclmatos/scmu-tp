import 'package:flutter/material.dart';
import 'package:hotncold/models/game_provider.dart';
import 'package:hotncold/models/user.dart';
import 'package:hotncold/pages/in_game/seeker.dart';
import 'package:hotncold/pages/in_game/hider.dart';
import 'package:provider/provider.dart';

class RoleWrapper extends StatelessWidget {
  const RoleWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final gameState = Provider.of<GameProvider>(context);
    final user = Provider.of<MyUser?>(context);

    if (gameState.state.rounds[gameState.state.currentRound].hider.email
            .compareTo(user!.email!) !=
        0) {
      return const Seeker();
    } else {
      return const Hider();
    }
  }
}
