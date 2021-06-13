import '../models/person.dart';
import '../util/dice.dart';

class Round {
  static const DICE_SIZE = 3;
  static const MAGIC_ROLL = 1;
  Dice _dice = new DiceBuilder().build(DiceBuilder.RANDOM);
  int _magicRoll = MAGIC_ROLL;

  Round() {}

  Round.simple(int magicRoll) {
    _magicRoll = magicRoll;
    _dice = new DiceBuilder().build(DiceBuilder.ALWAYS_ONE);
  }

  List<Person> play(List<Person> people) {
    List<Person> survivors = [];
    var index = 0;
    people.forEach((p) {
      final roll = _dice.roll(DICE_SIZE);
      var noSurivors = survivors.isEmpty;
      var onLastPlayer = (index == people.length - 1);
      var case1 = noSurivors && onLastPlayer;
      var case2 = (roll == _magicRoll);
      if (case1 || case2) {
        survivors.add(p);
      }
      index++;
    });
    return survivors;
  }
}
