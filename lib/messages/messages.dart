import 'package:flutter/material.dart';

Container registerMessage(
    BuildContext context, String name, String pwd, String confirm) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: const BoxDecoration(
      color: Colors.red,
      borderRadius: BorderRadius.all(Radius.circular(15)),
    ),
    child: Text(
      registerError(name, pwd, confirm),
      textAlign: TextAlign.center,
    ),
  );
}

Container loginMessage(BuildContext context, String name, String pwd) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: const BoxDecoration(
      color: Colors.red,
      borderRadius: BorderRadius.all(Radius.circular(15)),
    ),
    child: Text(
      loginError(name, pwd),
      textAlign: TextAlign.center,
    ),
  );
}

String registerError(String name, String pwd, String confirm) {
  String error = "";

  if (name == "") {
    error = "Please provide a username.";
  } else if (pwd == "") {
    error = "Please provide a password.";
  } else if (confirm == "") {
    error = "Please confirm your password.";
  } else if (pwd.compareTo(confirm) < 0) {
    error = "Password and confirmation don't match.";
  }

  return error;
}

String loginError(String name, String pwd) {
  String error = "";

  if (name == "") {
    error = "Please provide a username.";
  } else if (pwd == "") {
    error = "Please provide a password.";
  }

  return error;
}

Container postError(String message) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: const BoxDecoration(
      color: Colors.red,
      borderRadius: BorderRadius.all(Radius.circular(15)),
    ),
    child: Text(
      message,
      textAlign: TextAlign.center,
    ),
  );
}
