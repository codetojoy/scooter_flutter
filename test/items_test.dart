import 'package:scooter_flutter/util/items.dart';
import 'package:test/test.dart';

void main() {
  var items;

  group('Items', () {
    setUp(() {
      items = new Items();
    });

    test('shuffle basic', () {
      final values = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
      final numValues = 10;

      // test
      var result = items.shuffle(values);

      expect(numValues, result.length);
      var numMatches = 0;
      var index = 0;
      values.forEach((v) {
        expect(true, result.contains(v));
        if (v == result[index]) {
          numMatches++;
        }
        index++;
      });
      // this is a probablity-test and could fail
      // we are betting that 25% of the values have been shuffled
      expect(true, numMatches < (numValues * 0.75).floor());
    });

    // end group
  });
}
