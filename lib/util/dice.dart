import "dart:math";

abstract class Dice {
  int roll(int max);
}

class DiceBuilder {
  static const RANDOM = "random";

  Dice build(String s) {
    Dice result = _RandomDice();
    return result;
  }
}

class _RandomDice implements Dice {
  final _random = new Random();

  int roll(int max) {
    return _random.nextInt(max) + 1;
  }
}
