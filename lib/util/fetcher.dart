import './logger.dart';
import '../models/names.dart';
import '../models/person.dart';

abstract class Fetcher {
  Future<List<Person>> fetchPeople();
  Fetcher setPeople(List<Person> people);
}

class Fetchers {
  static const String TYPE_SIMPLE = "simple";
  static const String TYPE_LAZY = "lazy";
  static const String TYPE_API = "api";
  static const String TYPE_REFLEXIVE = "reflexive";

  Fetcher buildFetcher(String type) {
    Fetcher result = SimpleFetcher();
    if (type == TYPE_API) {
      // TODO
    } else if (type == TYPE_LAZY) {
      result = new LazyFetcher();
    } else if (type == TYPE_REFLEXIVE) {
      result = new ReflexiveFetcher();
    }
    return result;
  }
}

class SimpleFetcher implements Fetcher {
  Future<List<Person>> fetchPeople() async {
    L.log('hello from simple fetcher');
    final people = PLAYER_NAMES.map((String name) {
      return Person(name);
    }).toList();
    return Future.value(people);
  }

  Fetcher setPeople(List<Person> people) {
    return this;
  }
}

class LazyFetcher implements Fetcher {
  Future<List<Person>> fetchPeople() async {
    L.log('lazy fetcher sleeping');
    await Future.delayed(Duration(seconds: 10));
    L.log('lazy fetcher awake');
    return new SimpleFetcher().fetchPeople();
  }

  Fetcher setPeople(List<Person> people) {
    return this;
  }
}

class ReflexiveFetcher implements Fetcher {
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
