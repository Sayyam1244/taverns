import 'package:flutter/material.dart';
import 'package:taverns/presentation/chat_list/chat_list_navigator.dart';
import 'package:taverns/presentation/compendium/compendium_initial_params.dart';
import 'package:taverns/presentation/compendium/compendium_page.dart';
import '../../main.dart';
import '../../navigation/app_navigation.dart';

class CompendiumNavigator with ChatListRoute {
  @override
  late BuildContext context;

  @override
  final AppNavigator navigator;

  CompendiumNavigator(this.navigator);
}

mixin CompendiumRoute {
  openCompendium(CompendiumInitialParams initialParams) {
    navigator.push(
      context,
      CompendiumPage(cubit: getIt(param1: initialParams)),
    );
  }

  AppNavigator get navigator;

  BuildContext get context;
}
