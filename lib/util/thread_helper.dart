import 'dart:async';

class ThreadHelper {
  static Timer asNewInstance({
    required int milliseconds,
    required void Function() callback,
  }) {
    return Timer(Duration(milliseconds: milliseconds), callback);
  }
}
