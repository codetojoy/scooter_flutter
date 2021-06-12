import 'package:flutter/material.dart';

import '../models/person.dart';

class Player extends StatelessWidget {
  final Person _person;
  final bool _isAbbreviatedMode;

  Player(this._person, this._isAbbreviatedMode);

  @override
  Widget build(BuildContext context) {
    var fontSize = 12.0;
    var text = _person.name;
    if (_isAbbreviatedMode) {
      fontSize = 18.0;
      text = _person.shortName;
    }
    var textStyle = TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold);
    return InkWell(
        onTap: () { },
        splashColor: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(15),
        child: Container(
          padding: const EdgeInsets.all(15),
          child: Text(text,
              style: textStyle), // Theme.of(context).textTheme.headline6),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [_person.color.withOpacity(0.7), _person.color],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
        ));
  }
}
