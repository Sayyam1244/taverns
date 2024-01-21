import 'package:flutter/material.dart';
import 'package:taverns/presentation/edit_location_map/edit_location_on_map_navigator.dart';
import 'package:taverns/presentation/tavern_dasboard/tavern_dashboard_navigator.dart';
import '../../main.dart';
import '../../navigation/app_navigation.dart';
import 'edit_profile_initial_params.dart';
import 'edit_profile_page.dart';

class EditProfileNavigator with EditLocationOnMapRoute {
  @override
  late BuildContext context;

  @override
  final AppNavigator navigator;

  EditProfileNavigator(this.navigator);
}

mixin EditProfileRoute {
  openEditProfile(EditProfileInitialParams initialParams) {
    navigator.push(
      context,
      EditProfilePage(cubit: getIt(param1: initialParams)),
    );
  }

  openandRemoveProfile(EditProfileInitialParams initialParams) {
    navigator.pushAndRemoveCurrentOnly(
      context,
      EditProfilePage(cubit: getIt(param1: initialParams)),
    );
  }

  AppNavigator get navigator;

  BuildContext get context;
}
