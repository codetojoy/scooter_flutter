import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import './fetcher.dart';
import '../models/person.dart';
import '../util/logger.dart';

class _Api {
  static const LOCALHOST = 'localhost:8080';
  static const ANDROID_URI = '10.0.2.2:8080';
  String getUri() {
    var result = LOCALHOST;
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      // TODO
    } else if (defaultTargetPlatform == TargetPlatform.android) {
      result = ANDROID_URI;
    } else if ((defaultTargetPlatform == TargetPlatform.linux) ||
        (defaultTargetPlatform == TargetPlatform.macOS) ||
        (defaultTargetPlatform == TargetPlatform.windows)) {
      // TODO
    } else {
      // no-op
    }
    return result;
  }
}

class _ApiResult {
  List<Person> people = [];

  _ApiResult(this.people);

  factory _ApiResult.fromJson(Map<String, dynamic> json) {
    var msg = json['message'];
    print('REST message: $msg');
    var peopleJson = json['people'] as List<dynamic>;
    var peopleList = peopleJson.map<Person>((personJson) {
      var name = personJson['name'];
      return Person(name);
    }).toList();
    return _ApiResult(peopleList);
  }
}

// TODO: this should be in `services` (or similar) not `models`
class ApiFetcher extends Fetcher {
  static const context = '/scooter/players';

  Fetcher setPeople(List<Person> people) {
    return this;
  }

  Future<List<Person>> fetchPeople() async {
    var delay = 4;
    var doShuffle = true;
    var queryParams = {
      'delay_in_seconds': '$delay',
      'do_shuffle': '$doShuffle',
    };
    L.log('TRACER ApiFetcher');
    var host = new _Api().getUri();
    var url = Uri.http(host, context, queryParams);
    final response = await http.get(url);

    L.log('TRACER fetchCard status: ${response.statusCode}');
    if (response.statusCode == 200) {
      // re: UTF-8 issue: https://stackoverflow.com/questions/51368663
      return _ApiResult.fromJson(jsonDecode(utf8.decode(response.bodyBytes))).people;
    } else {
      throw Exception('Failed to load players');
    }
  }
}
