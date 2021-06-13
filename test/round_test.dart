import 'package:mockito/mockito.dart';
import 'package:scooter_flutter/models/person.dart';
import 'package:scooter_flutter/util/dice.dart';
import 'package:scooter_flutter/util/round.dart';
import 'package:test/test.dart';

class MockDice extends Mock implements Dice {
  int _fixedMagicRoll;

  MockDice(this._fixedMagicRoll);

  int roll(int max) {
    return _fixedMagicRoll;
  }
}

void main() {
  List<Person> people = [];
  late Dice dice;

  group('Round', () {
    setUp(() {
      people = [];
      people.add(Person('bach'));
      people.add(Person('chopin'));
      people.add(Person('liszt'));
      people.add(Person('mozart'));
    });
    test('all survive', () {
      int magicRoll = 1;
      dice = MockDice(magicRoll);
      final round = new Round.test(magicRoll, dice);

      // test
      final result = round.play(people);

      expect(4, result.length);
    });
    test('last one survives', () {
      int fixedRoll = 1;
      int magicRoll = 2;
      dice = MockDice(fixedRoll);
      final round = new Round.test(magicRoll, dice);

      // test
      final result = round.play(people);

      expect(1, result.length);
    });
  });
}
