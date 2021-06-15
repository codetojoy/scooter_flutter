import 'package:flutter/material.dart';

import './player.dart';
import './util/my_media_query.dart';
import '../models/person.dart';

class Players extends StatelessWidget {
  final List<Person> _people;
  final bool _isAbbreviatedMode;
  final AppBar _appBar;

  Players(this._people, this._isAbbreviatedMode, this._appBar);

/*
  Widget _buildLandscape(List<Widget> widgets, BuildContext context) {
    return Card(
        child: Container(
          child: GridView.count(
              primary: false,
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.all(10),
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
              crossAxisCount: 2,
              children: widgets),
          height: 400,
          width: 800,
        ),
        elevation: 10);
  }
*/

  Widget _buildLandscape2(List<Widget> widgets, BuildContext context) {
    final myMediaQuery = MyMediaQuery([0.90], context, _appBar);
    final availableHeight = myMediaQuery.values[0];
    return Card(
        child: Container(
            height: availableHeight,
            width: double.infinity,
            child: GridView(
                padding: const EdgeInsets.all(20),
                children: widgets,
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 120,
                  childAspectRatio: 3 / 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ))),
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        color: Theme.of(context).primaryColorLight);
  }

  Widget _buildPortrait2(List<Widget> widgets, BuildContext context) {
    return Card(
        child: Container(
            height: 400,
            width: double.infinity,
            child: GridView(
                padding: const EdgeInsets.all(10),
                children: widgets,
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 80,
                  childAspectRatio: 3 / 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ))),
        elevation: 10);
  }

/*
  Widget _buildPortrait(List<Widget> widgets, BuildContext context) {
    return Card(
        child: Container(
          child: GridView.count(
              primary: false,
              padding: const EdgeInsets.all(10),
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
              crossAxisCount: 3,
              children: widgets),
          height: 400,
          width: 300,
        ),
        elevation: 10);
  }
*/

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final isWinner = _people.length == 1;
    final widgets = _people.map<Widget>((Person person) {
      return Player(person, _isAbbreviatedMode, isWinner);
    }).toList();
    return (isLandscape)
        ? _buildLandscape2(widgets, context)
        : _buildLandscape2(widgets, context);
  }
}
