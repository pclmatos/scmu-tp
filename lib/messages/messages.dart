import 'package:flutter/material.dart';

Container errorMessage(
    BuildContext context, String name, String pwd, String confirm) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: const BoxDecoration(
      color: Colors.red,
      borderRadius: BorderRadius.all(Radius.circular(15)),
    ),
    child: Text(
      message(name, pwd, confirm),
      textAlign: TextAlign.center,
    ),
  );
}

String message(String name, String pwd, String confirm) {
  String error = "";

  if (name == "") {
    error = "Please provide a username.";
  } else if (pwd == "") {
    error = "Please provide a password.";
  } else if (confirm == "") {
    error = "Please confirm your password.";
  } else if (confirm.compareTo(pwd) < 0) {
    error = "Password and confirmation don't match.";
  }

  return error;
}

Container postError(BuildContext context, String message) {
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
