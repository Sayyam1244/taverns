import 'package:flutter/material.dart';
import 'package:taverns/presentation/how_to/how_to_initial_params.dart';
import 'package:taverns/presentation/how_to/how_to_page.dart';
import '../../main.dart';
import '../../navigation/app_navigation.dart';

class HowToNavigator {}

mixin HowToRoute {
  openHowTo(HowToInitialParams initialParams) {
    navigator.push(
      context,
      HowToPage(cubit: getIt(param1: initialParams)),
    );
  }

  AppNavigator get navigator;

  BuildContext get context;
}
