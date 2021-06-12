import "dart:math";

import 'package:flutter/material.dart';

class Dice {
  final _random = new Random();

  int roll(int max) {
    return _random.nextInt(max) + 1;
  }
}
