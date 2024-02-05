import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taverns/core/utils/flushbar.dart';
import 'package:taverns/domain/model/chat_model.dart';
import 'package:taverns/domain/model/chatroom_model.dart';
import 'package:taverns/domain/repository/auth_repository.dart';
import 'package:taverns/domain/repository/user_repository.dart';
import 'package:taverns/presentation/chat/chat_initial_params.dart';
import 'package:taverns/presentation/chat_list/chat_list_navigator.dart';
import 'chat_list_initial_params.dart';
import 'chat_list_state.dart';

class ChatListCubit extends Cubit<ChatListState> {
  final ChatListInitialParams initialParams;
  final UserRepository user;
  final AuthRepository auth;
  final ChatListNavigator navigator;
  ChatListCubit(this.initialParams, this.user, this.auth, this.navigator)
      : super(ChatListState.initial(initialParams: initialParams));

  getUsers(context) async {
    await user.getAllUsers().then(
          (value) => value.fold(
            (l) => FlushbarDialogue().showErrorFlushbar(
                context: context, title: l.title, body: l.message),
            (r) {
              r.removeWhere((element) => element == auth.currentUser().uid);
              emit(state.copyWith(users: r, isloading: false));
            },
          ),
        );
  }

  sendToUserAndNavigate({
    required String otherUserID,
    String? sheetName,
    String? type,
    String? content,
    int? level,
    String? system,
    String? category,
    String? subCategory,
    required BuildContext context,
  }) async {
    emit(state.copyWith(isloading: true));
    List<String> userIds = [auth.currentUser().uid, otherUserID]..sort();
    String chatRoomId = userIds.join("_");
    //
    ChatModel chatModel = ChatModel(
      content: content,
      userId: auth.currentUser().uid,
      TYPE: type,
      sheetName: sheetName,
      level: level,
      system: system,
      category: category,
      subCategory: subCategory,
    );
    log(chatRoomId);
    await user.sendMessage(chatModel: chatModel, chatRoomId: chatRoomId).then(
          (value) => value.fold(
            (l) => FlushbarDialogue().showErrorFlushbar(
                context: context, title: l.title, body: l.message),
            (r) => FlushbarDialogue().showFlushbar(
                context: context,
                title: 'Character Sheet',
                body: 'The Sheet has been successfully shared'),
          ),
        );
    emit(state.copyWith(isloading: false));
  }

  navigateTochaTscreen({required String otherUserUid, name}) {
    List<String> userIds = [auth.currentUser().uid, otherUserUid]..sort();
    String chatRoomId = userIds.join("_");
    ChatRoomModel chatRoomModel = ChatRoomModel(
        users: [auth.currentUser().uid, otherUserUid],
        docId: chatRoomId,
        otherUsername: name);
    navigator.openChat(ChatInitialParams(chatroom: chatRoomModel));
  }
}
