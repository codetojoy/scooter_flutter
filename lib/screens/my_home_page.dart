import 'package:flutter/material.dart';

import './about.dart';
import '../models/deck.dart';
import '../models/names.dart';
import '../models/person.dart';
import '../util/round.dart';
import '../widgets/Players.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Deck _deck;
  List<Person> _people = [];
  bool _inProgress = false;
  bool _isAbbreviatedMode = true;
  late AppBar _appBar;

  void init() {
    final numPeople = PLAYER_NAMES.length;
    _deck = Deck(numPeople);
    _deck.shuffle();
    _people = _deck.cards.map((int index) {
      final name = PLAYER_NAMES[index];
      return Person(name);
    }).toList();
  }

  void _shuffleHandler() {
    setState(() {
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
      final round = new Round();
      _people = round.play(_people);
    });
  }

  void _pushAbout() {
    Navigator.of(context).pushNamed(About.routeName);
  }

  @override
  Widget build(BuildContext context) {
    if (!_inProgress) {
      init();
    }
    _appBar = AppBar(
      title: Text(widget.title),
      actions: [
        IconButton(icon: Icon(Icons.info), onPressed: _pushAbout),
      ],
    );
    return Scaffold(
      appBar: _appBar,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Players(_people.toList(), _isAbbreviatedMode, _appBar),
          ],
        ),
      ),
      floatingActionButton:
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        FloatingActionButton(
          heroTag: "btnAbbreviatedMode",
          onPressed: _abbreviatedModeHandler,
          tooltip: 'Switch abbreviation',
          child: Icon((_isAbbreviatedMode) ? Icons.zoom_out : Icons.zoom_in),
        ),
        FloatingActionButton(
          heroTag: "btnShuffle",
          onPressed: _shuffleHandler,
          tooltip: 'Shuffle',
          child: Icon(Icons.replay),
        ),
        FloatingActionButton(
          heroTag: "btnPlay",
          onPressed: _playHandler,
          tooltip: 'Play',
          child: Icon(Icons.play_circle_filled),
        ),
      ]),
    );
  }
}
