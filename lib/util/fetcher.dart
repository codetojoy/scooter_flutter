import '../models/names.dart';
import '../models/person.dart';

abstract class Fetcher {
  List<Person> fetchPeople();
}

class Fetchers {
  static const String TYPE_SIMPLE = "simple";

  Fetcher buildFetcher(String s) {
    var result = SimpleFetcher();
    return result;
  }
}

class SimpleFetcher implements Fetcher {
  List<Person> fetchPeople() {
    final people = PLAYER_NAMES.map((String name) {
      return Person(name);
    }).toList();
    return people;
  }
}
