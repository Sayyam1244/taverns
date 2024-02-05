import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart' as either;
import 'package:intl/intl.dart';
import 'package:taverns/core/app_export.dart';
import 'package:taverns/domain/model/chat_model.dart';
import 'package:taverns/domain/model/db_models.dart';
import 'package:taverns/domain/model/general_model.dart';
import 'package:taverns/widgets/custom_text_form_field.dart';
import 'chat_cubit.dart';
import 'chat_state.dart';

class ChatPage extends StatefulWidget {
  final ChatCubit cubit;

  const ChatPage({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatState();
}

class _ChatState extends State<ChatPage> {
  ChatCubit get cubit => widget.cubit;
  TextEditingController msgController = TextEditingController();

  @override
  void initState() {
    super.initState();
    cubit.navigator.context = context;
  }

  @override
  Widget build(BuildContext context) {
    log(cubit.initialParams.chatroom.docId.toString());
    log(cubit.initialParams.chatroom.otherUsername.toString());
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70.v,
        backgroundColor: theme.colorScheme.background,
        elevation: 0,
        actions: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  String otherUid = cubit.initialParams.chatroom.users!
                      .firstWhere(
                          (element) => element != cubit.auth.currentUser().uid);
                  cubit.naviateToUserDetailScreen(otherUid);
                },
                child: Container(
                  margin: EdgeInsets.only(left: 50.h),
                  height: 45.adaptSize,
                  width: 45.adaptSize,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: theme.colorScheme.primary),
                  child: Text(
                    cubit.initialParams.chatroom.otherUsername
                        .toString()
                        .characters
                        .first,
                    style: CustomTextStyles.titlelarge
                        .copyWith(color: appTheme.white),
                  ),
                ),
              ),
              SizedBox(width: 12.h),
              Text(
                cubit.initialParams.chatroom.otherUsername ?? '',
                style: CustomTextStyles.titleMedium16,
              ),
            ],
          ),
          Spacer(),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<either.Either<GeneralError, List<ChatModel>>>(
                stream: cubit.user.getChatroomChats(
                    chatroomId: cubit.initialParams.chatroom.docId!),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.hasData) {
                    List<ChatModel> chats = [];
                    snapshot.data!.fold((l) => null, (r) => chats = r);
                    return ListView.builder(
                      reverse: true,
                      itemCount: chats.length,
                      itemBuilder: (context, index) {
                        // final data = chats.reversed.toList();
                        return ChatItem(
                          otherUserName:
                              cubit.initialParams.chatroom.otherUsername ?? '',
                          chat: chats[index],
                          uid: cubit.auth.currentUser().uid,
                          cubit: cubit,
                        );
                      },
                    );
                  } else {
                    return Container();
                  }
                }),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: CustomTextFormField(
              suffix: InkWell(
                onTap: () {
                  if (msgController.text.isNotEmpty) {
                    cubit.user.sendMessage(
                        chatModel: ChatModel(
                          userId: cubit.auth.currentUser().uid,
                          content: msgController.text,
                          TYPE: 'TEXT',
                        ),
                        chatRoomId: cubit.initialParams.chatroom.docId!);
                    msgController.clear();
                  }
                },
                child: Icon(
                  Icons.arrow_outward,
                  color: appTheme.blueGray900,
                  size: 16,
                ),
              ),
              controller: msgController,
              hintText: 'Write here...',
              autofocus: false,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            ),
          )
        ],
      ),
    );
  }
}

class ChatItem extends StatelessWidget {
  const ChatItem({
    Key? key,
    required this.chat,
    required this.uid,
    required this.otherUserName,
    required this.cubit,
  }) : super(key: key);

  final ChatModel chat;
  final String uid;
  final String otherUserName;
  final ChatCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Container(
              margin: EdgeInsets.only(bottom: 2),
              padding: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                  color: chat.userId != uid
                      ? appTheme.yellow50
                      : theme.colorScheme.primary,
                  borderRadius: BorderRadius.circular(4)),
              child: Text(
                chat.userId != uid ? otherUserName : 'Me',
                style: CustomTextStyles.bodySmallCircularStdBluegray40001
                    .copyWith(
                        fontSize: 8,
                        color: chat.userId != uid
                            ? appTheme.gray800
                            : appTheme.white),
              ),
            ),
          ),
          if (chat.TYPE == 'TEXT')
            Container(
              decoration: BoxDecoration(
                  color: chat.userId != uid
                      ? appTheme.yellow50
                      : theme.colorScheme.primary,
                  borderRadius: BorderRadius.circular(4)),
              padding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              child: Text(
                chat.content ?? '',
                style: CustomTextStyles.bodySmallMulishBluegray900.copyWith(
                    fontWeight: FontWeight.w400,
                    color:
                        chat.userId != uid ? appTheme.gray800 : appTheme.white),
              ),
            ),
          if (chat.TYPE != 'TEXT')
            Container(
              // margin: EdgeInsets.only(left: 20, right: 40),
              decoration: BoxDecoration(
                color: chat.userId != uid
                    ? appTheme.yellow50
                    : theme.colorScheme.primary,
                borderRadius: BorderRadius.circular(4),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      cubit.saveInDb(context: context, chatModel: chat);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Icon(Icons.download,
                          color: chat.userId != uid
                              ? appTheme.gray800
                              : appTheme.white),
                    ),
                  ),
                  Text(
                    chat.content ?? '',
                    style: CustomTextStyles.bodySmallMulishBluegray900.copyWith(
                        fontWeight: FontWeight.w400,
                        color: chat.userId != uid
                            ? appTheme.gray800
                            : appTheme.white),
                  ),
                ],
              ),
            ),
          Padding(
            padding: const EdgeInsets.only(top: 2, bottom: 10),
            child: Text(
              chat.createdDate == null
                  ? ''
                  : DateFormat('dd/MM/yyyy hh:mm:a').format(chat.createdDate!),
              style:
                  CustomTextStyles.bodySmallCircularStdBluegray40001.copyWith(
                fontSize: 10,
              ),
            ),
          )
        ],
      ),
    );
  }
}
