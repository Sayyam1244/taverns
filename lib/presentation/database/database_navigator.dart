import 'package:flutter/material.dart';
import 'package:taverns/presentation/character_sheets/character_sheets_navigator.dart';
import 'package:taverns/presentation/compendium/compendium_navigator.dart';
import 'package:taverns/presentation/database/database_initial_params.dart';
import 'package:taverns/presentation/database/database_page.dart';
import '../../main.dart';
import '../../navigation/app_navigation.dart';

class DatabaseNavigator with CharacterSheetsRoute, CompendiumRoute {
  @override
  late BuildContext context;

  @override
  final AppNavigator navigator;

  DatabaseNavigator(this.navigator);
}

mixin DatabaseRoute {
  openDatabase(DatabaseInitialParams initialParams) {
    navigator.push(
      context,
      DatabasePage(cubit: getIt(param1: initialParams)),
    );
  }

  AppNavigator get navigator;

  BuildContext get context;
}
