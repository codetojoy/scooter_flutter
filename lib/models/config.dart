import '../util/fetcher.dart';

class Config {
  Config._() {}

  Fetcher getFetcher() {
    return Fetchers().buildFetcher(Fetchers.TYPE_LAZY);
  }

  Fetcher getReflexiveFetcher() {
    return Fetchers().buildFetcher(Fetchers.TYPE_REFLEXIVE);
  }

  static Config instance = new Config._();
}
