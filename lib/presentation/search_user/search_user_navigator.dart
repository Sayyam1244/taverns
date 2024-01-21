import 'package:flutter/material.dart';
import 'package:taverns/presentation/search_user/search_user_initial_params.dart';
import 'package:taverns/presentation/search_user/search_user_page.dart';
import '../../main.dart';
import '../../navigation/app_navigation.dart';

class SearchUserNavigator {}

mixin SearchUserRoute {
  openSearchUser(SearchUserInitialParams initialParams) {
    navigator.push(
      context,
      SearchUserPage(cubit: getIt(param1: initialParams)),
    );
  }

  AppNavigator get navigator;

  BuildContext get context;
}
