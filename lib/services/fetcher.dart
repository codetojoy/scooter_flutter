import './api_fetcher.dart';
import '../models/person.dart';
import '../util/logger.dart';

abstract class Fetcher {
  Future<List<Person>> fetchPeople();
  Fetcher setPeople(List<Person> people);
}

class Fetchers {
  static const String TYPE_API = "api";
  static const String TYPE_SLOW = "slow";
  static const String TYPE_REFLEXIVE = "reflexive";
  static const String TYPE_SIMPLE = "simple";

  Fetcher buildFetcher(String type) {
    Fetcher result = _SimpleFetcher();
    if (type == TYPE_API) {
      result = new ApiFetcher();
    } else if (type == TYPE_SLOW) {
      result = new _SlowFetcher();
    } else if (type == TYPE_REFLEXIVE) {
      result = new _ReflexiveFetcher();
    }
    return result;
  }
}

class _SimpleFetcher implements Fetcher {
  static const _PLAYER_NAMES = [
    "Johann Sebastian Bach",
    "Ludwig van Beethoven",
    "Wolfgang Amadeus Mozart",
    "Franz Schubert",
    "Richard Wagner",
    "Antonio Vivaldi",
    "Johannes Brahms",
    "Giuseppe Verdi",
    "Robert Schumann",
    "Giacomo Puccini",
    "Antonín Dvorák",
    "George Handel",
    "Franz Liszt",
    "Joseph Haydn",
    "Frédéric Chopin",
    "Igor Stravinsky",
    "Gustav Mahler",
    "Richard Strauss",
    "Dmitri Shostakovich",
    "Hector Berlioz",
  ];

  Future<List<Person>> fetchPeople() async {
    L.log('hello from simple fetcher');
    final people = _PLAYER_NAMES.map((String name) {
      return Person(name);
    }).toList();
    return Future.value(people);
  }

  Fetcher setPeople(List<Person> people) {
    return this;
  }
}

class _SlowFetcher implements Fetcher {
  Future<List<Person>> fetchPeople() async {
    L.log('lazy fetcher sleeping');
    await Future.delayed(Duration(seconds: 10));
    L.log('lazy fetcher awake');
    return new _SimpleFetcher().fetchPeople();
  }

  Fetcher setPeople(List<Person> people) {
    return this;
  }
}

class _ReflexiveFetcher implements Fetcher {
  late List<Person> _people;

  Future<List<Person>> fetchPeople() async {
    L.log('hello from reflexive fetcher');
    return Future.value(_people);
  }

  Fetcher setPeople(List<Person> people) {
    _people = people;
    return this;
  }
}
