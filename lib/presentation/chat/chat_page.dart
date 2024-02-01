import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart' as either;
import 'package:intl/intl.dart';
import 'package:taverns/core/app_export.dart';
import 'package:taverns/domain/model/chat_model.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70.v,
        backgroundColor: theme.colorScheme.background,
        elevation: 0,
        actions: [
          Row(
            children: [
              Container(
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
                  if (snapshot.hasData) {
                    List<ChatModel> chats = [];
                    snapshot.data!.fold((l) => null, (r) => chats = r);
                    return ListView.builder(
                      reverse: true,
                      itemCount: chats.length,
                      itemBuilder: (context, index) {
                        final data = chats.reversed.toList();
                        return Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            child: Container(
                              width: MediaQuery.sizeOf(context).width * .7,
                              child: Column(
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.sizeOf(context).width * .7,
                                    decoration: BoxDecoration(
                                        color: theme.colorScheme.primary,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20),
                                          bottomLeft: Radius.circular(20),
                                        )),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 16,
                                    ),
                                    child: Text(
                                      chats[index].content ?? '',
                                      style: CustomTextStyles
                                          .titleSmallStd14Bwhite,
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 2),
                                      child: Text(
                                        DateFormat('dd/MM/yyyy hh:mm:a')
                                            .format(chats[index].createdDate!),
                                        style: CustomTextStyles
                                            .bodySmallSFProBluegray40001,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return Container();
                  }
                }),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary,
                    shape: BoxShape.circle,
                  ),
                  margin: EdgeInsets.only(right: 8),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Icon(
                    Icons.add,
                    color: appTheme.white,
                    size: 16,
                  ),
                ),
                Expanded(
                    child: CustomTextFormField(
                  controller: msgController,
                  hintText: 'Write here...',
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                )),
                Container(
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary,
                    shape: BoxShape.circle,
                  ),
                  margin: EdgeInsets.only(left: 8),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: InkWell(
                    onTap: () {
                      if (msgController.text.isNotEmpty) {
                        // msgs.add(msgController.text);
                        // setState(() {});
                        // msgController.clear();
                      }
                    },
                    child: Icon(
                      Icons.arrow_outward,
                      color: appTheme.white,
                      size: 16,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
