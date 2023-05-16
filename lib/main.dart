import 'package:flutter/material.dart';
import 'package:hotncold/models/room_state.dart';
import 'package:hotncold/models/user.dart';
import 'package:hotncold/pages/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hotncold/services/auth.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  Provider.debugCheckInvalidValueType = null;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ChangeNotifierProvider(
      create: (_) => RoomState({}, 0), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<MyUser?>.value(
      value: AuthService().user,
      initialData: MyUser(uid: '', email: ''),
      child: const MaterialApp(
        title: "Hot n' Cold",
        home: Wrapper(),
      ),
    );
  }
}
