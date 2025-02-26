import 'package:flutter/material.dart';

class ControlHelper {
  static void postTask(
    void Function() action,
  ) async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      action();
    });
    return;
  }
}
