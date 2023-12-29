import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class FlushbarDialogue {
  showErrorFlushbar({required BuildContext context, String title = '', body}) {
    return Flushbar(
      flushbarPosition: FlushbarPosition.TOP,
      backgroundColor: Theme.of(context).colorScheme.error,
      margin: const EdgeInsets.all(12),
      borderRadius: BorderRadius.circular(4),
      title: title,
      message: body,
      duration: const Duration(seconds: 2),
    )..show(context);
  }
  showFlushbar({required BuildContext context, String title = '', body}) {
    return Flushbar(
      flushbarPosition: FlushbarPosition.TOP,
      backgroundColor: Theme.of(context).primaryColorDark,
      margin: const EdgeInsets.all(12),
      borderRadius: BorderRadius.circular(4),
      title: title,
      message: body,
      duration: const Duration(seconds: 2),
    )..show(context);
  }
}