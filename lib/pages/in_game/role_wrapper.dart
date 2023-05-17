import 'package:flutter/material.dart';
import 'package:hotncold/models/game_provider.dart';
import 'package:hotncold/models/room_state.dart';
import 'package:hotncold/models/user.dart';
import 'package:hotncold/pages/in_game/seeker.dart';
import 'package:hotncold/pages/in_game/hider.dart';
import 'package:provider/provider.dart';

class RoleWrapper extends StatelessWidget {
  const RoleWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GameProvider>(builder: (context, gameProvider, child) {
      final gameState = gameProvider.state;
      final user = Provider.of<MyUser?>(context);

      if (user?.email!.compareTo(
              gameState.rounds[gameState.currentRound].hider.email) !=
          0) {
        return const Seeker();
      } else {
        return const Hider();
      }
    });
  }
}
