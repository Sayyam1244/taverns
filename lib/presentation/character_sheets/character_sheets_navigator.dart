import 'package:flutter/material.dart';
import 'package:taverns/presentation/character_sheets/character_sheets_initial_params.dart';
import 'package:taverns/presentation/character_sheets/character_sheets_page.dart';
import 'package:taverns/presentation/chat_list/chat_list_navigator.dart';
import '../../main.dart';
import '../../navigation/app_navigation.dart';

class CharacterSheetsNavigator with ChatListRoute {
  @override
  late BuildContext context;

  @override
  final AppNavigator navigator;

  CharacterSheetsNavigator(this.navigator);
}

mixin CharacterSheetsRoute {
  openCharacterSheets(CharacterSheetsInitialParams initialParams) {
    navigator.push(
      context,
      CharacterSheetsPage(cubit: getIt(param1: initialParams)),
    );
  }

  AppNavigator get navigator;

  BuildContext get context;
}
