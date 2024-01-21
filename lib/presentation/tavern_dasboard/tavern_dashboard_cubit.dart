import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taverns/domain/repository/auth_repository.dart';
import 'package:taverns/domain/repository/events_repository.dart';
import 'package:taverns/domain/repository/user_repository.dart';
import 'package:taverns/presentation/chat/chat_initial_params.dart';
import 'package:taverns/presentation/event_detail/event_detail_initial_params.dart';
import 'package:taverns/presentation/notification_board/notification_board_initial_params.dart';
import 'package:taverns/presentation/notifications/notifications_initial_params.dart';
import 'package:taverns/presentation/reviews/reviews_initial_params.dart';
import 'package:taverns/presentation/search_event/search_event_initial_params.dart';
import 'package:taverns/presentation/search_user/search_user_initial_params.dart';
import 'package:taverns/presentation/tavern_dasboard/tavern_dashboard_navigator.dart';
import 'package:taverns/presentation/tavern_profile/tavern_profile_initial_params.dart';
import '../../core/utils/flushbar.dart';
import 'tavern_dashboard_initial_params.dart';
import 'tavern_dashboard_state.dart';

class TavernDashboardCubit extends Cubit<TavernDashboardState> {
  final TavernDashboardInitialParams initialParams;
  final TavernDashboardNavigator navigator;
  final AuthRepository auth;
  final UserRepository _user;
  final EventRepository events;
  TavernDashboardCubit(
      this.initialParams, this.navigator, this.auth, this._user, this.events)
      : super(
          TavernDashboardState.initial(
            initialParams: initialParams,
          ),
        );

  void navigateToNotificaitonBoard() {
    log("name " + state.user.businessName.toString());

    navigator.openNotificationBoard(
        NotificationBoardInitialParams(userModel: state.user));
  }

  update(int i) {
    emit(state.copyWith(currentIndex: i));
  }

  getUserData(context) async {
    _user.getUser(auth.currentUser().uid).then((value) {
      return value.fold(
        (l) => FlushbarDialogue().showErrorFlushbar(
            context: context, title: l.title, body: l.message),
        (r) async {
          await getReviewsData();
          emit(state.copyWith(user: r, isloading: false));
        },
      );
    });
  }

  void updateDates(DateTime selectedDay, DateTime focusedDay) {
    emit(state.copyWith(selectedDay: selectedDay, focusedDay: focusedDay));
  }

  void navigateToTavernProfileDetail() {
    navigator
        .openTavernProfile(TavernProfileInitialParams(state.user.docId!, true));
  }

  void navigateToNotifications() {
    navigator.openNotifications(NotificationsInitialParams());
  }

  void navigateTosearchEvent() {
    navigator.openSearchEvent(SearchEventInitialParams());
  }

  void navigateToChatScreen({required String otherUserId}) {
    navigator.openChat(ChatInitialParams(chatRoomId: 'asd'));
  }

  void navigateToUserSearch() {
    navigator.openSearchUser(SearchUserInitialParams());
  }

  void navigateToEventDetailScreen(String? docId) {
    navigator.openEventDetail(EventDetailInitialParams(docId!));
  }

  void navigateToReviews() {
    navigator.openReviews(ReviewsInitialParams(auth.currentUser().uid));
  }

  Future<void> getReviewsData() async {
    await events.getUserReviews(userId: auth.currentUser().uid).then((value) {
      return value.fold(
        (l) => null,
        (r) {
          List<int> n = r.map((e) => e.stars ?? 0).toList();
          int sum = 0;
          n.forEach((element) {
            sum = sum + (element ?? 0);
          });

          emit(state.copyWith(reviewCount: r.length, stars: sum));
          log("count" + r.length.toString());
        },
      );
    });
  }
}
