import 'package:flutter/material.dart';
import 'package:taverns/presentation/chat/chat_navigator.dart';
import 'package:taverns/presentation/event_detail/event_detail_navigator.dart';
import 'package:taverns/presentation/notification_board/notification_board_navigator.dart';
import 'package:taverns/presentation/reviews/reviews_navigator.dart';
import 'package:taverns/presentation/search_event/search_event_navigator.dart';
import 'package:taverns/presentation/search_user/search_user_navigator.dart';
import 'package:taverns/presentation/tavern_profile/tavern_profile_navigator.dart';
import '../../main.dart';
import '../../navigation/app_navigation.dart';
import 'tavern_dashboard_initial_params.dart';
import 'tavern_dashboard_page.dart';

class TavernDashboardNavigator with NotificationBoardRoute, ReviewsRoute, TavernProfileRoute, SearchEventRoute, SearchUserRoute, ChatRoute, EventDetailRoute {
  @override
  late BuildContext context;

  @override
  final AppNavigator navigator;

  TavernDashboardNavigator(this.navigator);
}

mixin TavernDashboardRoute {
  openTavernDashboard(TavernDashboardInitialParams initialParams) {
    navigator.push(
      context,
      TavernDashboardPage(cubit: getIt(param1: initialParams)),
    );
  }

  AppNavigator get navigator;

  BuildContext get context;
}
