import 'package:flutter/material.dart';

import './player.dart';
import '../models/person.dart';

class Players extends StatelessWidget {
  final List<Person> _people;
  final bool _isAbbreviatedMode;

  Players(this._people, this._isAbbreviatedMode);

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

  Widget _buildLandscape2(List<Widget> widgets, BuildContext context) {
    return Card(
        child: Container(
            height: 600,
            width: double.infinity,
            child: GridView(
                padding: const EdgeInsets.all(10),
                children: widgets,
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 80,
                  childAspectRatio: 3 / 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ))),
        elevation: 10);
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

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final widgets = _people.map<Widget>((Person person) {
      return Player(person, _isAbbreviatedMode);
    }).toList();
    return (isLandscape)
        ? _buildLandscape2(widgets, context)
        : _buildPortrait2(widgets, context);
  }
}
