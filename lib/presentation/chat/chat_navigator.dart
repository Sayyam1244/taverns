import 'package:flutter/material.dart';
import '../../main.dart';
import '../../navigation/app_navigation.dart';
import 'chat_initial_params.dart';
import 'chat_page.dart';

class ChatNavigator {}

mixin ChatRoute {
  openChat(ChatInitialParams initialParams) {
    navigator.push(
      context,
      ChatPage(cubit: getIt(param1: initialParams)),
    );
  }

  AppNavigator get navigator;

  BuildContext get context;
}
