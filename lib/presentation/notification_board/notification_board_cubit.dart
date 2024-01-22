import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:taverns/core/app_export.dart';
import 'package:taverns/core/utils/datetime_picker.dart';
import 'package:taverns/domain/model/event_model.dart';
import 'package:taverns/domain/model/notification_model.dart';
import 'package:taverns/domain/model/request_model.dart';
import 'package:taverns/domain/repository/auth_repository.dart';
import 'package:taverns/domain/repository/events_repository.dart';
import 'package:taverns/domain/repository/notification_repository.dart';
import 'package:taverns/domain/repository/user_repository.dart';
import 'package:taverns/presentation/notification_board/notification_board_navigator.dart';
import 'package:taverns/presentation/notification_board/sub_components/request_item.dart';
import '../../core/utils/flushbar.dart';
import '../../domain/model/general_model.dart';
import '../../widgets/custom_elevated_button.dart';
import 'notification_board_initial_params.dart';
import 'notification_board_state.dart';

class NotificationBoardCubit extends Cubit<NotificationBoardState> {
  final NotificationBoardInitialParams initialParams;
  final NotificationBoardNavigator navigator;
  final AuthRepository auth;
  final UserRepository _user;
  final EventRepository event;
  final NotificationRepository notification;
  NotificationBoardCubit(this.initialParams, this.navigator, this.auth,
      this._user, this.event, this.notification)
      : super(
          NotificationBoardState.initial(
            initialParams: initialParams,
          ),
        );
  changeIndex(int i) {
    emit(state.copyWith(index: i));
  }

  updateDate(context) async {
    final DateTime dateTime =
        await DatetimePicker().selectDate(context, state.eventDatetime);
    emit(
      state.copyWith(
        eventDatetime: DateTime(
          dateTime.year,
          dateTime.month,
          dateTime.day,
          state.eventDatetime.hour,
          state.eventDatetime.minute,
        ),
      ),
    );
  }

  updateTime(context) async {
    final TimeOfDay time =
        await DatetimePicker().selectTime(context, state.eventDatetime);
    emit(
      state.copyWith(
        eventDatetime: DateTime(
          state.eventDatetime.year,
          state.eventDatetime.month,
          state.eventDatetime.day,
          time.hour,
          time.minute,
        ),
      ),
    );
  }

  updatePostData({
    String? eventName,
    String? eventType,
    String? gameType,
    String? gameSystem,
    bool? isFree,
    int? gmsRequired,
    int? playerRequired,
    int? tables,
    String? note,
  }) {
    emit(state.copyWith(
        eventName: eventName,
        eventType: eventType,
        gameType: gameType,
        gameSystem: gameSystem,
        isFree: isFree,
        gmsRequired: gmsRequired,
        playerRequired: playerRequired,
        tables: tables,
        note: note));
  }

  Future<void> postEvent(
    BuildContext context,
  ) async {
    log('asdf' + initialParams.userModel.businessName.toString());
    EventModel eventModel = EventModel(
      businessName: initialParams.userModel.businessName ?? '',
      businessNumber: initialParams.userModel.businessNumber ?? '',
      userId: initialParams.userModel.docId ?? '',
      businessAddress: initialParams.userModel.businessAddress ?? '',
      eventName: state.eventName!,
      eventDatetime: state.eventDatetime,
      eventType: state.eventType!,
      gameType: state.gameType!,
      gameSystem: state.gameSystem!,
      isFree: state.isFree!,
      gmsRequired: state.gmsRequired!,
      playerRequired: state.playerRequired!,
      tables: state.tables!,
      note: state.note ?? '',
    );
    emit(state.copyWith(isPostUploading: true));
    await event.postEvent(event: eventModel).then(
          (value) => value.fold(
            (l) => FlushbarDialogue().showErrorFlushbar(
                context: context, title: l.title, body: l.message),
            (r) {
              FlushbarDialogue().showFlushbar(
                  context: context,
                  title: 'Event Uploaded',
                  body: 'Your Post has been uploaded successfully');
            },
          ),
        );
    emit(state.copyWith(isPostUploading: false));
  }

  Future openRequests(String? docId, int maxGm, int maxPlayers, context,
      NotificationBoardCubit cubit) {
    return showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return BlocBuilder<NotificationBoardCubit, NotificationBoardState>(
          bloc: cubit,
          builder: (context, state) => Container(
            height: MediaQuery.sizeOf(context).height * .9,
            decoration: BoxDecoration(
              color: appTheme.gray5001,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: StreamBuilder<Either<GeneralError, List<RequestModel>>>(
              stream: cubit.event.getRequests(eventId: docId),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  int currentGm = 0;
                  int currentPlayer = 0;
                  List<RequestModel> data = [];
                  List<RequestModel> gmRequests = [];
                  List<RequestModel> playerRequests = [];
                  snapshot.data?.fold((l) => null, (r) {
                    currentGm = r
                        .where((element) {
                          return (element.requestedFor == "GM" &&
                              element.isApproved == true);
                        })
                        .toList()
                        .length;
                    currentPlayer = r
                        .where((element) {
                          return (element.requestedFor == "Player" &&
                              element.isApproved == true);
                        })
                        .toList()
                        .length;
                    data = r;
                    data.removeWhere((element) => element.isApproved != null);
                    gmRequests = data
                        .where((element) => element.requestedFor == "GM")
                        .toList();
                    playerRequests = data
                        .where((element) => element.requestedFor == "Player")
                        .toList();
                  });

                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                            alignment: Alignment.topRight,
                            child: IconButton(
                              icon: Icon(Icons.close),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            )),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: CustomElevatedButton(
                                onPressed: () {
                                  emit(state.copyWith(
                                      isCurrentGMButtonSelected: true));
                                },
                                buttonStyle: state.isCurrentGMButtonSelected
                                    ? CustomButtonStyles.fillPrimaryTL8
                                    : CustomButtonStyles.fillYellow,
                                buttonTextStyle: state.isCurrentGMButtonSelected
                                    ? CustomTextStyles
                                        .titleSmallOnErrorContainer
                                    : CustomTextStyles
                                        .titleSmallCircularStdBluegray70001,
                                height: 45.v,
                                text: 'Current GM $currentGm/$maxGm',
                              ),
                            ),
                            SizedBox(width: 12.h),
                            Expanded(
                              child: CustomElevatedButton(
                                onPressed: () {
                                  emit(state.copyWith(
                                      isCurrentGMButtonSelected: false));
                                },
                                buttonStyle: !state.isCurrentGMButtonSelected
                                    ? CustomButtonStyles.fillPrimaryTL8
                                    : CustomButtonStyles.fillYellow,
                                buttonTextStyle:
                                    !state.isCurrentGMButtonSelected
                                        ? CustomTextStyles
                                            .titleSmallOnErrorContainer
                                        : CustomTextStyles
                                            .titleSmallCircularStdBluegray70001,
                                height: 45.v,
                                text:
                                    'Current Players $currentPlayer/$maxPlayers',
                              ),
                            ),
                          ],
                        ),
                        if (state.isCurrentGMButtonSelected &&
                            (currentGm < maxGm))
                          Expanded(
                            child: ListView.separated(
                              separatorBuilder: (
                                context,
                                index,
                              ) {
                                return SizedBox(width: 16.h);
                              },
                              itemCount: gmRequests.length,
                              itemBuilder: (context, index) {
                                return RequestItem(
                                  requestModel: gmRequests[index],
                                  cubit: cubit,
                                );
                              },
                            ),
                          ),
                        if (!state.isCurrentGMButtonSelected &&
                            (currentPlayer < maxPlayers))
                          Expanded(
                            child: ListView.separated(
                              separatorBuilder: (
                                context,
                                index,
                              ) {
                                return SizedBox(width: 16.h);
                              },
                              itemCount: playerRequests.length,
                              itemBuilder: (context, index) {
                                return RequestItem(
                                  requestModel: playerRequests[index],
                                  cubit: cubit,
                                );
                              },
                            ),
                          ),
                        if (!state.isCurrentGMButtonSelected &&
                            (currentPlayer == maxPlayers))
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Text(
                              'Maximum requests for this event has been approved for players slots',
                              textAlign: TextAlign.center,
                              style:
                                  CustomTextStyles.bodySmallMulishBluegray900,
                            ),
                          ),
                        if (state.isCurrentGMButtonSelected &&
                            (currentGm == maxGm))
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Text(
                              'Maximum requests for this event has been approved for GM slots',
                              textAlign: TextAlign.center,
                              style:
                                  CustomTextStyles.bodySmallMulishBluegray900,
                            ),
                          )
                      ],
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
        );
      },
    );
  }

  void requestApproved(
      bool bool, requestId, RequestModel requestModel, context) {
    event
        .approveRequest(
            approve: bool, requestId: requestId, eventId: requestModel.eventId!)
        .then(
          (value) => value.fold(
            (l) => FlushbarDialogue().showErrorFlushbar(
                context: context, title: l.title, body: l.message),
            (r) async {
              NotificationModel notificationModel = NotificationModel(
                  notification:
                      'Your request for ${requestModel.requestedFor} has been ${bool ? "Approved" : "Rejected"}',
                  to: requestModel.userId,
                  from: auth.currentUser().uid,
                  eventId: requestModel.eventId,
                  sender: initialParams.userModel.accountType == "Tavern"
                      ? initialParams.userModel.businessName
                      : initialParams.userModel.userName);
              await notification.generateNotification(
                  notificationModel: notificationModel);
              return FlushbarDialogue().showFlushbar(
                  context: context,
                  title: 'Request',
                  body:
                      "Request ${bool ? "Approved" : "Rejected"} successfully!");
            },
          ),
        );
  }
}
