import "package:flutter/material.dart";

Container background() {
  return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 201, 42, 31),
                Color.fromARGB(255, 44, 124, 228)
              ],
              begin: FractionalOffset.centerLeft,
              end: FractionalOffset.centerRight,
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp)));
}
