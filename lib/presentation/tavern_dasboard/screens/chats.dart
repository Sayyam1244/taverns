import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:intl/intl.dart';
import 'package:taverns/core/app_export.dart';
import 'package:taverns/domain/model/chatroom_model.dart';
import 'package:taverns/domain/model/general_model.dart';
import 'package:taverns/presentation/tavern_dasboard/tavern_dashboard_cubit.dart';

class Chats extends StatelessWidget {
  const Chats({Key? key, required this.cubit}) : super(key: key);
  final TavernDashboardCubit cubit;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: appTheme.white,
      child: Column(
        children: [
          Container(
            height: 65.v,
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Text(
                  'Message',
                  style: CustomTextStyles.titleMedium16,
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    cubit.navigateToUserSearch();
                  },
                  child: CustomImageView(
                    height: 17,
                    imagePath: ImageConstant.searchIcon,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              child: StreamBuilder<Either<GeneralError, List<ChatRoomModel>>>(
                  stream: cubit.userHelper
                      .getChats(userId: cubit.auth.currentUser().uid),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<ChatRoomModel> data = [];
                      snapshot.data!.fold((l) => null, (r) => data = r);
                      log(cubit.auth.currentUser().uid);
                      log(data.length.toString());
                      return ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, index) => ChatItem(
                                ontap: () {
                                  cubit.navigateToChatScreen(
                                      chatRoomModel: data[index]);
                                },
                                imagePath:
                                    cubit.state.user.profilePicture ?? '',
                                title: data[index].otherUsername!,
                                subtitle: data[index].last!,
                                newMessage: false,
                                dateTime:
                                    data[index].lastModified ?? DateTime.now(),
                              ));
                    } else {
                      return Container();
                    }
                  }))
        ],
      ),
    );
  }
}

class ChatItem extends StatelessWidget {
  const ChatItem({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.subtitle,
    required this.newMessage,
    required this.ontap,
    required this.dateTime,
  }) : super(key: key);
  final String imagePath;
  final String title;
  final String subtitle;
  final bool newMessage;
  final DateTime dateTime;
  final VoidCallback ontap;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.v,
      margin: EdgeInsets.symmetric(horizontal: 8),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        // color: Colors.amber,
      ),
      child: MaterialButton(
        padding: EdgeInsets.all(0),
        onPressed: ontap,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            children: [
              Container(
                height: 43.adaptSize,
                width: 43.adaptSize,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(imagePath), fit: BoxFit.cover),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: theme.colorScheme.primary,
                    width: 1,
                  ),
                ),
              ),
              SizedBox(width: 12.h),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: CustomTextStyles.titleSmallStd14Bluegrey,
                  ),
                  SizedBox(height: 4.v),
                  Container(
                    width: MediaQuery.sizeOf(context).width * .7,
                    child: Row(
                      children: [
                        Container(
                          width: MediaQuery.sizeOf(context).width * .5,
                          child: Text(
                            subtitle,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: CustomTextStyles.bodySmallMulishBluegray900,
                          ),
                        ),
                        Spacer(),
                        Text(
                          DateFormat('hh:mm: a').format(dateTime),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: CustomTextStyles.bodySmallMulishBluegray900,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Spacer(),
              newMessage
                  ? Icon(
                      Icons.circle,
                      size: 10,
                      color: Colors.green,
                    )
                  : Container()
            ],
          ),
        ),
      ),
    );
  }
}
