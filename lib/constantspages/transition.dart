import 'package:flutter/material.dart';

Widget transition(String text, AnimationController controler) {
  return SlideTransition(
    position: Tween<Offset>(begin: Offset(0.0, -0.9), end: Offset.zero)
        .animate(controler),
    child: Text(
      text,
      style: TextStyle(color: Colors.white.withOpacity(1), fontSize: 30),
      textAlign: TextAlign.center,
    ),
  );
}

Widget image(String img) {
  return Center(
    child: Image(
      image: AssetImage(img),
    ),
  );
}
