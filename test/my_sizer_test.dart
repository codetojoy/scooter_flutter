import 'package:flutter/material.dart';
import 'package:scooter_flutter/widgets/util/my_sizer.dart';
import 'package:test/test.dart';

void main() {
  group('MySizer', () {
    final appBarHeight = 10.0;
    final topPaddingHeight = 10.0;

    setUp(() {});

    test('values basic', () {
      List<double> percentages = [0.1, 0.2, 0.3, 0.4];
      Size size = Size(100.0, 200.0);
      var mySizer =
          new MySizer(percentages, size, appBarHeight, topPaddingHeight);

      // test
      var values = mySizer.values;

      expect(180.0, mySizer.availableHeight);
      var index = 0;
      var factor = 1;
      expect(18.0 * (factor++), values[index++]);
      expect(18.0 * (factor++), values[index++]);
      expect(18.0 * (factor++), values[index++]);
      expect(18.0 * (factor++), values[index++]);
    });

    // end group
  });
}
