import 'package:flutter/material.dart';

import '../widgets/util/my_colors.dart';

// TODO: we probably don't want Color in a model... maybe a String?
class Card {
  final _value;
  Color color = new MyColors().getRandom();

  Card(this._value);

  get value => _value;

  String toString() {
    return '$_value';
  }
}
