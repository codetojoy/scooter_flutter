import 'package:flutter/material.dart';

import './about.dart';
import '../models/config.dart';
import '../models/person.dart';
import '../util/items.dart';
import '../util/round.dart';
import '../widgets/Players.dart';

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Person> _people = [];
  bool _inProgress = false;
  bool _isAbbreviatedMode = true;
  late AppBar _appBar;
  Future<List<Person>> _playersFuture =
      Config.instance.getFetcher().fetchPeople();

  void _shuffle() {
    _people = new Items().shuffle(_people);
  }

  void _setFuture() {
    if (_people.isEmpty) {
      _playersFuture = Config.instance.getFetcher().fetchPeople();
    } else {
      _playersFuture = Config.instance
          .getReflexiveFetcher()
          .setPeople(_people)
          .fetchPeople();
    }
  }

  void _reloadHandler() {
    setState(() {
      _inProgress = false;
      _people = [];
      _setFuture();
    });
  }

  void _shuffleHandler() {
    setState(() {
      if (_people.isNotEmpty) {
        _shuffle();
      }
      _setFuture();
    });
  }

  void _abbreviatedModeHandler() {
    setState(() {
      _isAbbreviatedMode = !_isAbbreviatedMode;
      // for a new game, if user switches mode, we should consider the
      // game started
      _inProgress = true;
    });
  }

  void _playHandler() {
    setState(() {
      _inProgress = true;
      final round = new Round();
      _people = round.play(_people);
      _setFuture();
    });
  }

  void _pushAbout() {
    Navigator.of(context).pushNamed(About.routeName);
  }

  List<Widget> _buildHasData(
      BuildContext context, AsyncSnapshot<List<Person>> snapshot) {
    List<Widget> children = [];
    List<Person>? result = snapshot.data;
    if (result != null) {
      _people = result.toList();
      children = [Players(_people, _isAbbreviatedMode, _appBar)];
    } else {
      children = [
        Text('internal error'),
      ];
    }
    return children;
  }

  List<Widget> _buildError(
      BuildContext context, AsyncSnapshot<List<Person>> snapshot) {
    List<Widget> children = <Widget>[
      const Icon(
        Icons.error_outline,
        color: Colors.red,
        size: 60,
      ),
      Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Text('Error: ${snapshot.error}'),
      )
    ];
    return children;
  }

  List<Widget> _buildBusy(
      BuildContext context, AsyncSnapshot<List<Person>> snapshot) {
    List<Widget> children = <Widget>[
      SizedBox(
        child: CircularProgressIndicator(),
        width: 60,
        height: 60,
      ),
      Padding(
        padding: EdgeInsets.only(top: 16),
        child: Text('Loading players...'),
      )
    ];
    return children;
  }

  Widget _buildMain(BuildContext context) {
    return DefaultTextStyle(
      style: Theme.of(context).textTheme.headline6!,
      textAlign: TextAlign.center,
      child: FutureBuilder<List<Person>>(
        future: _playersFuture,
        builder: (BuildContext context, AsyncSnapshot<List<Person>> snapshot) {
          List<Widget> children = [];
          if (snapshot.connectionState != ConnectionState.done) {
            children = _buildBusy(context, snapshot);
          } else if (snapshot.hasError) {
            children = _buildError(context, snapshot);
          } else if (snapshot.hasData) {
            children = _buildHasData(context, snapshot);
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: children,
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!_inProgress) {
      _setFuture();
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
        child: _buildMain(context),
      ),
      floatingActionButton:
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        FloatingActionButton(
          heroTag: "btnReload",
          onPressed: _reloadHandler,
          tooltip: 'Reload',
          child: Icon(Icons.replay),
        ),
        FloatingActionButton(
          heroTag: "btnShuffle",
          onPressed: _shuffleHandler,
          tooltip: 'Shuffle',
          child: Icon(Icons.shuffle),
        ),
        FloatingActionButton(
          heroTag: "btnAbbreviatedMode",
          onPressed: _abbreviatedModeHandler,
          tooltip: 'Switch abbreviation',
          child: Icon((_isAbbreviatedMode) ? Icons.zoom_out : Icons.zoom_in),
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
