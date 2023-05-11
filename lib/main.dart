import 'package:flutter/material.dart';
import 'package:hotncold/models/user.dart';
import 'package:hotncold/pages/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hotncold/services/auth.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<MyUser?>.value(
      value: AuthService().user,
      initialData: MyUser(uid: ""),
      child: const MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}
