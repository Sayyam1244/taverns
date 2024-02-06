import 'package:flutter/material.dart';
import 'package:taverns/presentation/quality_of_life/quality_of_life_initial_params.dart';
import 'package:taverns/presentation/quality_of_life/quality_of_life_page.dart';
import '../../main.dart';
import '../../navigation/app_navigation.dart';

class QualityOfLifeNavigator {}

mixin QualityOfLifeRoute {
  openQualityOfLife(QualityOfLifeInitialParams initialParams) {
    navigator.push(
      context,
      QualityOfLifePage(cubit: getIt(param1: initialParams)),
    );
  }

  AppNavigator get navigator;

  BuildContext get context;
}
