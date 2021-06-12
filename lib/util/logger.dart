import 'package:intl/intl.dart';

class L {
  static void log(String s) {
    var now = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

    print('TRACER [$now] => $s');
  }
}
