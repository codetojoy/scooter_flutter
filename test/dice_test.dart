import 'package:scooter_flutter/util/dice.dart';
import 'package:test/test.dart';

void main() {
  final dice = new DiceBuilder().build(DiceBuilder.RANDOM);
  test('roll basic', () {
    final max = 4;
    final numRolls = 20;

    for (var i = 0; i < numRolls; i++) {
      // test
      final result = dice.roll(max);
      expect(true, result >= 1);
      expect(true, result <= max);
    }
  });
}
