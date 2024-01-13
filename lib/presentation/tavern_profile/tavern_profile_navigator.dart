import 'package:flutter/material.dart';
import 'package:taverns/presentation/tavern_profile/tavern_profile_initial_params.dart';
import 'package:taverns/presentation/tavern_profile/tavern_profile_page.dart';
import '../../main.dart';
import '../../navigation/app_navigation.dart';

class TavernProfileNavigator {}

mixin TavernProfileRoute {
  openTavernProfile(TavernProfileInitialParams initialParams) {
    navigator.push(
      context,
      TavernProfilePage(cubit: getIt(param1: initialParams)),
    );
  }

  AppNavigator get navigator;

  BuildContext get context;
}
