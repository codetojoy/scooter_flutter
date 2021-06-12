import 'package:flutter/material.dart';

import '../widgets/util/my_colors.dart';

// TODO: we probably don't want Color in a model... maybe a String?
class Person {
  final _name;
  final color = new MyColors().getRandom();

  Person(this._name);

  get name => _name;

  get shortName {
    var result = "";
    _name.split(" ").forEach((String token) => result += token[0]);
    return result;
  }

  String toString() {
    return '$_name';
  }
}
