import 'package:flutter/material.dart';
import 'package:hybrid_app/extension/localization.dart';

class DialogHelper {
  static Future<void> showDetailDialog({
    required BuildContext context,
    required Widget title,
    required Widget content,
  }) async {
    await showDialog(
      context: context,
      builder: (context) => buildDialog(
        context: context,
        title: title,
        content: content,
      ),
    );
  }

  static List<Widget> buildSimpleAction({
    required BuildContext context,
  }) {
    return [
      TextButton(
        child: Text(context.localization.okay),
        onPressed: () {
          Navigator.of(context).pop();
        },
      )
    ];
  }

  static Widget buildDialog({
    required BuildContext context,
    required Widget title,
    required Widget content,
  }) {
    return AlertDialog(
      title: title,
      content: content,
      actions: buildSimpleAction(context: context),
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
      title: context.localization.error_occured,
      content: content,
    );
  }

  static Future<void> showStatefulDialog({
    required BuildContext context,
    required Widget Function(BuildContext context, void Function(void Function()) setState) builder,
  }) async {
    await showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: builder,
        );
      },
    );
  }
}
