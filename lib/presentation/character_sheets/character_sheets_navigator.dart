import 'package:flutter/material.dart';
import 'package:taverns/presentation/character_sheets/character_sheets_initial_params.dart';
import 'package:taverns/presentation/character_sheets/character_sheets_page.dart';
import '../../main.dart';
import '../../navigation/app_navigation.dart';

class CharacterSheetsNavigator {}

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
