import 'package:flutter/material.dart';
import 'package:taverns/presentation/edit_profile/edit_profile_navigator.dart';
import '../../main.dart';
import '../../navigation/app_navigation.dart';
import 'edit_location_on_map_initial_params.dart';
import 'edit_location_on_map_page.dart';

class EditLocationOnMapNavigator with EditProfileRoute {
  @override
  late BuildContext context;

  @override
  final AppNavigator navigator;

  EditLocationOnMapNavigator(this.navigator);
}

mixin EditLocationOnMapRoute {
  openEditLocationOnMap(EditLocationOnMapInitialParams initialParams) {
    navigator.push(
      context,
      EditLocationOnMapPage(cubit: getIt(param1: initialParams)),
    );
  }

  openAndRemoveCurrentEditLocationOnMap(EditLocationOnMapInitialParams initialParams) {
    navigator.pushAndRemoveCurrentOnly(
      context,
      EditLocationOnMapPage(cubit: getIt(param1: initialParams)),
    );
  }

  AppNavigator get navigator;

  BuildContext get context;
}
