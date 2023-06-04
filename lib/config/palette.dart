import 'package:flutter/material.dart';

class Palette {
  static const Color scaffold = Color(0xFFF7F7D7);
  static const Color white = Color(0xFFFFFFFF);
  static const Color tyldcYellow = Color(0xFFF1F106);
  static const Color grey = Color(0xFF878781);

  static const LinearGradient createRoomGradient = LinearGradient(
    colors: [Color(0xFF496AE1), Color(0xFFCE48B1)],
  );

  static const Color online = Color(0xFF4BCB1F);

  static const LinearGradient storyGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Colors.transparent, Colors.black26],
  );
}
