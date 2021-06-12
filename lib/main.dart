import 'package:flutter/material.dart';

import './models/card.dart' as waro_c;
import './models/names.dart';
import './models/deck.dart';
import './models/person.dart';
import './widgets/Players.dart';
import './util/dice.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scooter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Scooter'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  Deck _deck = new Deck(1);
  Iterable<Person> _people = [];
  bool _inProgress = false;
  bool _isAbbreviatedMode = true;

  void init() {
      final numPeople = PLAYER_NAMES.length;
      _deck = Deck(numPeople);
      _deck.shuffle();
      _people = _deck.cards.map((waro_c.Card c) {
        final index = c.value - 1;
        final name = PLAYER_NAMES[index];
        return Person(name);
      });
  }

  void _shuffleHandler() {
    setState(() {
      _counter++;
      init();
    });
  }

  void _abbreviatedModeHandler() {
    setState(() {
      _isAbbreviatedMode = !_isAbbreviatedMode;
    });
  }

  void _playHandler() {
    setState(() {
      _inProgress = true;
      final dice = new Dice();
      _people = _people.where((p) {
        final roll = dice.roll(3);
        print('TRACER play handler roll: $roll');
        return 1 == roll;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_inProgress) {
      init();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Players(_people.toList(), _isAbbreviatedMode),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children:[
      FloatingActionButton(
        onPressed: _abbreviatedModeHandler,
        tooltip: 'Switch abbreviation',
        child: Icon((_isAbbreviatedMode) ? Icons.zoom_out : Icons.zoom_in),
      ),
      FloatingActionButton(
        onPressed: _shuffleHandler,
        tooltip: 'Shuffle',
        child: Icon(Icons.replay),
      ),
      FloatingActionButton(
        onPressed: _playHandler,
        tooltip: 'Play',
        child: Icon(Icons.play_circle_filled),
      ),
      ]),
    );
  }
}
