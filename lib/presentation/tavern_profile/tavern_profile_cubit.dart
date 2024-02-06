import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taverns/domain/model/chatroom_model.dart';
import 'package:taverns/domain/repository/auth_repository.dart';
import 'package:taverns/domain/repository/events_repository.dart';
import 'package:taverns/domain/repository/user_repository.dart';
import 'package:taverns/presentation/chat/chat_initial_params.dart';
import 'package:taverns/presentation/edit_profile/edit_profile_initial_params.dart';
import 'package:taverns/presentation/tavern_profile/tavern_profile_navigator.dart';
import '../../core/utils/flushbar.dart';
import 'tavern_profile_initial_params.dart';
import 'tavern_profile_state.dart';

class TavernProfileCubit extends Cubit<TavernProfileState> {
  final TavernProfileInitialParams initialParams;
  final UserRepository _user;
  final TavernProfileNavigator navigator;
  final AuthRepository auth;
  final EventRepository events;
  TavernProfileCubit(
      this.initialParams, this._user, this.navigator, this.auth, this.events)
      : super(TavernProfileState.initial(initialParams: initialParams));

  getTavernUserInfo(context) {
    _user.getUser(initialParams.docId).then((value) {
      return value.fold(
        (l) => FlushbarDialogue().showErrorFlushbar(
            context: context, title: l.title, body: l.message),
        (r) async {
          getReviewsData();
          emit(
            state.copyWith(isloading: false, userModel: r),
          );
        },
      );
    });
  }

  Future<void> getReviewsData() async {
    await events.getUserReviews(userId: initialParams.docId).then((value) {
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

  void navigateToEditProfileScreen() {
    navigator.openandRemoveProfile(
        EditProfileInitialParams(userModel: state.userModel));
  }

  void chat(String docId, name) {
    List<String> userIds = [auth.currentUser().uid, docId]..sort();
    String chatRoomId = userIds.join("_");
    ChatRoomModel chatRoomModel = ChatRoomModel(
      users: [auth.currentUser().uid, docId],
      otherUsername: name,
      docId: chatRoomId,
    );
    navigator.openChat(ChatInitialParams(chatroom: chatRoomModel));
  }
}
