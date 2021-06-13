import 'package:flutter/material.dart';

import './screens/about.dart';
import './screens/my_home_page.dart';
import './util/constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: C.TITLE,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: C.ROOT_ROUTE,
        routes: {
          C.ROOT_ROUTE: (ctx) => MyHomePage(title: C.TITLE),
          About.routeName: (ctx) => About(),
        });
  }
}
