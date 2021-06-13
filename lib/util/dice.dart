import "dart:math";

abstract class Dice {
  int roll(int max);
}

class DiceBuilder {
  // TODO: use enum or put AlwaysOne into a test as a mock
  static const RANDOM = "random";
  static const ALWAYS_ONE = "alwaysOne";

  Dice build(String s) {
    Dice result = _RandomDice();
    if (s == ALWAYS_ONE) {
      result = _AlwaysOneDice();
    }
    return result;
  }
}

class _AlwaysOneDice implements Dice {
  int roll(int max) {
    return 1;
  }
}

class _RandomDice implements Dice {
  final _random = new Random();

  int roll(int max) {
    return _random.nextInt(max) + 1;
  }
}
