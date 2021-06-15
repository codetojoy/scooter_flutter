import '../util/fetcher.dart';

class Config {
  Config._() {}

  Fetcher getFetcher() {
    final fetcher = Fetchers().buildFetcher(Fetchers.TYPE_SIMPLE);
    return fetcher;
  }

  static Config instance = new Config._();
}
