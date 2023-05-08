import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';

AppBar header(context) {
  return AppBar(
      centerTitle: true,
      backgroundColor: const Color.fromARGB(255, 207, 207, 207),
      title: Text(
        "Hot N' Cold",
        style:
            GoogleFonts.getFont("Pacifico", color: Colors.black, fontSize: 35),
      ));
}
