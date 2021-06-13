import 'package:scooter_flutter/models/person.dart';
import 'package:scooter_flutter/util/round.dart';
import 'package:test/test.dart';

void main() {
  List<Person> people = [];

  group('Round', () {
    setUp(() {
      people.add(Person('bach'));
      people.add(Person('chopin'));
      people.add(Person('liszt'));
      people.add(Person('mozart'));
    });
    test('all survive', () {
      int magicRoll = 1;
      final round = new Round.simple(magicRoll);

      // test
      final result = round.play(people);

      expect(4, result.length);
    });
    test('last one survives', () {
      int magicRoll = 2;
      final round = new Round.simple(magicRoll);

      // test
      final result = round.play(people);

      expect(1, result.length);
    });
  });
}
