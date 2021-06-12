import '../../util/logger.dart';

class DoubleAuditor {
  static const _percentageEpsilon = 0.01;
  static const _valueEpsilon = 0.9;

  double _sum(List<double> values) {
    return values.reduce((a, b) => a + b);
  }

  bool auditPercentages(List<double> percentages) {
    double percentageSum = _sum(percentages);

    final result = (percentageSum - 1).abs() < _percentageEpsilon;
    if (!result) {
      L.log('audit percentages sum: $percentageSum e: 1');
      percentages.forEach((p) {
        L.log('p: $p');
      });
    }

    return result;
  }

  bool auditValues(List<double> values, double expected) {
    double valueSum = _sum(values);

    final result = (valueSum - expected).abs() < _valueEpsilon;
    if (!result) {
      L.log('audit values sum: $valueSum e: $expected');
    }
    return result;
  }
}
