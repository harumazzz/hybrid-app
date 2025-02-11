import 'package:flutter/material.dart';

class DialogHelper {
  static Future<void> showDetailDialog({
    required BuildContext context,
    required Widget title,
    required Widget content,
  }) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: title,
        content: content,
        actions: [
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
  }

  static Future<void> showSimpleDialog({
    required BuildContext context,
    required String title,
    required String content,
  }) async {
    return await showDetailDialog(
      context: context,
      title: Text(title),
      content: Text(content),
    );
  }

  static Future<void> showErrorDialog({
    required BuildContext context,
    required String content,
  }) async {
    return await showSimpleDialog(
      context: context,
      title: 'Lỗi xảy ra',
      content: content,
    );
  }
}
