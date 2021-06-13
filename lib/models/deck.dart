import 'dart:math';

class Deck {
  final List<int> _cards;

  Deck(int numCards) : _cards = new List<int>.generate(numCards, (i) => i);

  List<int> get cards => _cards;

  void shuffle() {
    var rng = new Random();
    for (var i = _cards.length - 1; i > 0; i--) {
      final j = rng.nextInt(_cards.length);
      final temp = _cards[i];
      _cards[i] = _cards[j];
      _cards[j] = temp;
    }
  }

  String toString() {
    var result = "";
    _cards.forEach((c) {
      result += '$c ';
    });
    return result;
  }
}
