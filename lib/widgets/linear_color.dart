import'package:flutter/material.dart';


BoxDecoration buildContainerDecoration() {
  return const BoxDecoration(
    gradient: LinearGradient(
      colors: [
        Color(0xffB89D4A),
        Color(0xffE9E3F0),
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      stops: [0.1, 0.7],
      tileMode: TileMode.clamp,
    ),
  );
}


