import "dart:math";

import 'package:flutter/material.dart';

class MyColors {
  final _random = new Random();
  final _colors = [
    Colors.purple,
    Colors.red,
    Colors.orange,
    Colors.amber,
    Colors.blue,
    Colors.green,
    Colors.lightBlue,
    Colors.lightGreen,
    Colors.pink,
    Colors.teal,
  ];

  Color getRandom() {
    return _colors[_random.nextInt(_colors.length)];
  }
}
