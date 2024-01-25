import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:taverns/core/app_export.dart';
import 'package:taverns/core/utils/datetime_picker.dart';
import 'package:taverns/domain/model/event_model.dart';
import 'package:taverns/domain/model/keyboolModel.dart';
import 'package:taverns/domain/model/notification_model.dart';
import 'package:taverns/domain/model/request_model.dart';
import 'package:taverns/domain/repository/auth_repository.dart';
import 'package:taverns/domain/repository/events_repository.dart';
import 'package:taverns/domain/repository/notification_repository.dart';
import 'package:taverns/domain/repository/user_repository.dart';
import 'package:taverns/presentation/notification_board/notification_board_navigator.dart';
import 'package:taverns/presentation/notification_board/sub_components/request_item.dart';
import 'package:taverns/presentation/pulls_nearby_businesses/pull_nearby_businesses_initial_params.dart';
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
      BuildContext context, bool isTavernOwnerPosting) async {
    EventModel eventModel = EventModel(
      businessName: isTavernOwnerPosting
          ? initialParams.userModel!.businessName ?? ''
          : initialParams.userModelForOtherTavern!.businessName ?? '',
      businessNumber: isTavernOwnerPosting
          ? initialParams.userModel!.businessNumber ?? ''
          : '',
      userId: initialParams.userModel!.docId ?? '',
      businessAddress: isTavernOwnerPosting
          ? initialParams.userModel!.businessAddress ?? ''
          : initialParams.userModelForOtherTavern!.businessAddress ?? '',
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
      isApproved: isTavernOwnerPosting ? true : null,
      requestedTavern: initialParams.userModelForOtherTavern?.docId ?? null,
      eventUsers: isTavernOwnerPosting ? [auth.currentUser().uid] : [],
    );
    emit(state.copyWith(isPostUploading: true));
    await event.postEvent(event: eventModel).then(
          (value) => value.fold(
            (l) => FlushbarDialogue().showErrorFlushbar(
                context: context, title: l.title, body: l.message),
            (r) async {
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
        .addInEvent(
            eventId: requestModel.eventId!, userId: requestModel.userId!)
        .then((value) {
      return value.fold(
        (l) => FlushbarDialogue().showErrorFlushbar(
            context: context, title: l.title, body: l.message),
        (r) async {
          event
              .approveRequest(
                  approve: bool,
                  requestId: requestId,
                  eventId: requestModel.eventId!)
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
                        sender: initialParams.userModel!.accountType == "Tavern"
                            ? initialParams.userModel!.businessName
                            : initialParams.userModel!.userName);
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
        },
      );
    });
  }

  void navigateToPullsNearby() {
    navigator.openAndRemoveCurrentPullNearbyBusinesses(
        PullNearbyBusinessesInitialParams(initialParams.userModel!));
  }

  void approveEventRequest(bool bool, EventModel eventModel) async {
    event.updateEventRequest(approve: bool, eventId: eventModel.docId);
    if (bool) {
      await event.addInEvent(
          eventId: eventModel.docId!, userId: eventModel.userId);
      await event.addInEvent(
          eventId: eventModel.docId!, userId: auth.currentUser().uid);
    }
    NotificationModel notificationModel = NotificationModel(
        notification:
            'Your request for ${eventModel.eventName} has been ${bool ? "Approved" : "Rejected"}',
        to: eventModel.userId,
        from: auth.currentUser().uid,
        eventId: eventModel.docId,
        sender: initialParams.userModel!.accountType == "Tavern"
            ? initialParams.userModel!.businessName
            : initialParams.userModel!.userName);
    await notification.generateNotification(
        notificationModel: notificationModel);
  }

  void requestToJoin(
      {required EventModel event, required BuildContext context}) {
    RequestModel requestModel = RequestModel(
      userName: initialParams.userModel!.userName!,
      userId: initialParams.userModel!.docId,
      eventId: event.docId,
      requestedFor: initialParams.userModel!.accountType,
    );
    this.event.makeRequest(requestModel: requestModel).then(
          (value) => value.fold(
            (l) => FlushbarDialogue().showErrorFlushbar(
                context: context, title: l.title, body: l.message),
            (r) async {
              if (r) {
                NotificationModel notificationModel = NotificationModel(
                    notification:
                        'Requested a slot for ${requestModel.requestedFor} in ${event.eventName}',
                    to: event.userId,
                    from: auth.currentUser().uid,
                    eventId: event.docId,
                    sender: initialParams.userModel!.userName);

                await notification.generateNotification(
                    notificationModel: notificationModel);
                return FlushbarDialogue().showFlushbar(
                  context: context,
                  title: 'Request',
                  body:
                      'Your request for ${initialParams.userModel!.accountType} has been submitted for the following event',
                );
              } else {
                return FlushbarDialogue().showFlushbar(
                  context: context,
                  title: 'Request',
                  body: 'Your request for this event is already submitted',
                );
              }
            },
          ),
        );
  }

  void setIndex() {
    emit(state.copyWith(index: initialParams.index ?? 0));
  }

  toggleFilterVisibility() {
    emit(state.copyWith(showFilter: !state.showFilter!));
    log(state.showFilter.toString());
  }

  void changeOnlyTavernGm(int index) {
    List<KeyBoolModel> ls = state.tavernGmOnly;
    ls[index] = KeyBoolModel(title: ls[index].title, istrue: !ls[index].istrue);
    emit(state.copyWith(tavernGmOnly: ls));
  }

  void applyFilters(bool bool) {
    if (bool) {
      emit(state.copyWith(isFilterApplied: bool, showFilter: false));
    } else {
      List<KeyBoolModel> ls = state.otherFilters;
      List<KeyBoolModel> ls2 = state.tavernGmOnly;
      emit(state.copyWith(
          showFilter: false,
          isFilterApplied: false,
          otherFilters: ls,
          tavernGmOnly: ls2));
    }
  }

  void changeFilterByIndex(int index) {
    List<KeyBoolModel> ls = state.otherFilters;
    ls[index] = KeyBoolModel(title: ls[index].title, istrue: !ls[index].istrue);
    emit(state.copyWith(otherFilters: ls));
  }
}
