
import 'dart:math';

class Indices {
  final List<int> _values;

  Indices(int numCards) : _values = new List<int>.generate(numCards, (i) => i);

  List<int> get values => _values;

  void shuffle() {
    var rng = new Random();
    for (var i = _values.length - 1; i > 0; i--) {
      final j = rng.nextInt(_values.length);
      final temp = _values[i];
      _values[i] = _values[j];
      _values[j] = temp;
    }
  }
}

class Items {
  List<T> shuffle<T>(List<T> items) {
    var indices = Indices(items.length);
    indices.shuffle();
    return indices.values.map((int index) {
      return items[index];
    }).toList();
  }
}
