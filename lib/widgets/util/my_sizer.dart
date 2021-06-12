import 'package:flutter/material.dart';

import './double_auditor.dart';

class MySizer {
  List<double> values = [];
  List<double> _percentages = [];
  var availableHeight;
  var totalHeight;
  var totalWidth;

  final auditor = new DoubleAuditor();

  MySizer(List<double> percentages, Size size, double appBarHeight,
      double topPaddingHeight) {
    totalHeight = size.height;
    totalWidth = size.width;
    availableHeight = totalHeight - (appBarHeight + topPaddingHeight);

    _percentages = percentages;
    values = _percentages.map<double>((percentage) {
      return availableHeight * percentage;
    }).toList();
  }

  bool audit() {
    return auditPercentages() && auditValues();
  }

  bool auditPercentages() {
    return auditor.auditPercentages(_percentages);
  }

  bool auditValues() {
    return auditor.auditValues(values, availableHeight);
  }
}
