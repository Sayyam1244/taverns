import 'package:flutter/material.dart';

class AppNavigator {
  push(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }

  pushAndReplace(BuildContext context, Widget page) {
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => page), (route) => false);
  }

  navigateBack(BuildContext context) {
    Navigator.pop(context);
  }
}
