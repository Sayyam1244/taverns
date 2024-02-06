import 'package:flutter/material.dart';
import 'package:taverns/presentation/faqs/faqs_initial_params.dart';
import 'package:taverns/presentation/faqs/faqs_page.dart';
import '../../main.dart';
import '../../navigation/app_navigation.dart';

class FaqsNavigator {}

mixin FaqsRoute {
  openFaqs(FaqsInitialParams initialParams) {
    navigator.push(
      context,
      FaqsPage(cubit: getIt(param1: initialParams)),
    );
  }

  AppNavigator get navigator;

  BuildContext get context;
}
