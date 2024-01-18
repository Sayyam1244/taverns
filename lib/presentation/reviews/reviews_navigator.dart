import 'package:flutter/material.dart';
import 'package:taverns/presentation/reviews/reviews_initial_params.dart';
import 'package:taverns/presentation/reviews/reviews_page.dart';
import '../../main.dart';
import '../../navigation/app_navigation.dart';

class ReviewsNavigator {}

mixin ReviewsRoute {
  openReviews(ReviewsInitialParams initialParams) {
    navigator.push(
      context,
      ReviewsPage(cubit: getIt(param1: initialParams)),
    );
  }

  AppNavigator get navigator;

  BuildContext get context;
}
