import 'package:flutter/material.dart';

Widget background(String img) {
  return Container(
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage(img),
        fit: BoxFit.fill,
      ),
    ),
  );
}

RadialGradient getcolor() {
  return RadialGradient(
    colors: [
      Color.fromARGB(255, 239, 84, 84).withOpacity(0),
      const Color.fromARGB(255, 236, 76, 76).withOpacity(0),
      Color.fromARGB(255, 236, 106, 106).withOpacity(0),
      Color.fromARGB(255, 232, 65, 65).withOpacity(0.8),
      Color.fromARGB(255, 231, 68, 68).withOpacity(0.8),
      Color.fromARGB(255, 237, 68, 68).withOpacity(1),
      Color.fromARGB(255, 236, 23, 30).withOpacity(1),
    ],
    center: Alignment.center,
    radius: 0.1,
    //stops: [0.1, 0.3, 0.1],
  );
}

// get color for my users foods views

LinearGradient getusercolor() {
  return LinearGradient(
    colors: [
      Color.fromARGB(255, 231, 69, 69).withOpacity(1),
      Color.fromARGB(255, 240, 60, 60).withOpacity(0.9),
      Color.fromARGB(255, 241, 44, 44).withOpacity(0.8),
      Color.fromARGB(255, 228, 34, 34).withOpacity(0.8),
      Color.fromARGB(255, 241, 36, 36).withOpacity(0.6),
      Color.fromARGB(255, 248, 65, 65).withOpacity(0.4),
      Color.fromARGB(255, 223, 29, 36).withOpacity(0.07),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    //stops: [0.1, 0.3, 0.1],
  );
}

Widget colorsbackgroud() {
  return Container(
    decoration: BoxDecoration(
      gradient: getcolor(),
    ),
    //color: Colors.red.withOpacity(0.5),
  );
}
