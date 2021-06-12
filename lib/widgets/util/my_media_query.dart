import 'package:flutter/material.dart';
import 'package:scooter_flutter/widgets/util/my_sizer.dart';

class MyMediaQuery {
  var _mySizer;

  MyMediaQuery(List<double> percentages, BuildContext context, AppBar appBar) {
    _init(percentages, context, appBar);
  }

  MyMediaQuery.simple(BuildContext context, AppBar appBar) {
    _init([], context, appBar);
  }

  void _init(List<double> percentages, BuildContext context, AppBar appBar) {
    final mediaQuery = MediaQuery.of(context);
    final topPaddingHeight = mediaQuery.padding.top;
    final appBarHeight = appBar.preferredSize.height;
    _mySizer = new MySizer(
        percentages, mediaQuery.size, appBarHeight, topPaddingHeight);
  }

  double get availableHeight => _mySizer.availableHeight;
  double get totalHeight => _mySizer.totalHeight;
  double get totalWidth => _mySizer.totalWidth;
  List<double> get values => _mySizer.values;

  bool audit() {
    return _mySizer.audit();
  }

  bool auditPercentages() {
    return _mySizer.auditPercentages();
  }

  bool auditValues() {
    return _mySizer.auditValues();
  }
}
