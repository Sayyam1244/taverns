import 'package:flutter/material.dart';
import 'package:taverns/presentation/chat/chat_navigator.dart';
import 'package:taverns/presentation/chat_list/chat_list_initial_params.dart';
import 'package:taverns/presentation/chat_list/chat_list_page.dart';
import '../../main.dart';
import '../../navigation/app_navigation.dart';

class ChatListNavigator with ChatRoute {
  @override
  late BuildContext context;

  @override
  final AppNavigator navigator;

  ChatListNavigator(this.navigator);
}

mixin ChatListRoute {
  openChatList(ChatListInitialParams initialParams) {
    navigator.push(
      context,
      ChatListPage(cubit: getIt(param1: initialParams)),
    );
  }

  AppNavigator get navigator;

  BuildContext get context;
}
