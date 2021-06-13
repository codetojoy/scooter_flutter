import 'package:scooter_flutter/widgets/util/double_auditor.dart';
import 'package:test/test.dart';

void main() {
  var auditor;

  group('DoubleAuditor', () {
    setUp(() {
      auditor = new DoubleAuditor();
    });

    test('audit values green', () {
      var availableHeight = 100.0;
      var values = [25.0, 50.0, 25.0];

      // test
      var result = auditor.auditValues(values, availableHeight);

      expect(true, result);
    });

    test('audit values red', () {
      var availableHeight = 100.0;
      var values = [24.0, 50.0, 25.0];

      // test
      var result = auditor.auditValues(values, availableHeight);

      expect(false, result);
    });

    test('audit percentage green', () {
      var percentages = [0.25, 0.5, 0.25];
      // test
      var result = auditor.auditPercentages(percentages);

      expect(true, result);
    });

    test('audit percentage red', () {
      var percentages = [0.2, 0.5, 0.25];
      // test
      var result = auditor.auditPercentages(percentages);

      expect(false, result);
    });
    // end group
  });
}
