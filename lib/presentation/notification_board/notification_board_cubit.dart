import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:taverns/core/app_export.dart';
import 'package:taverns/core/utils/datetime_picker.dart';
import 'package:taverns/domain/model/event_model.dart';
import 'package:taverns/domain/model/request_model.dart';
import 'package:taverns/domain/repository/auth_repository.dart';
import 'package:taverns/domain/repository/events_repository.dart';
import 'package:taverns/domain/repository/user_repository.dart';
import 'package:taverns/presentation/notification_board/notification_board_navigator.dart';
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
  NotificationBoardCubit(this.initialParams, this.navigator, this.auth, this._user, this.event)
      : super(
          NotificationBoardState.initial(
            initialParams: initialParams,
          ),
        );
  changeIndex(int i) {
    emit(state.copyWith(index: i));
  }

  updateDate(context) async {
    final DateTime dateTime = await DatetimePicker().selectDate(context, state.eventDatetime);
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
    final TimeOfDay time = await DatetimePicker().selectTime(context, state.eventDatetime);
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
            (l) => FlushbarDialogue().showErrorFlushbar(context: context, title: l.title, body: l.message),
            (r) {
              FlushbarDialogue().showFlushbar(context: context, title: 'Event Uploaded', body: 'Your Post has been uploaded successfully');
            },
          ),
        );
    emit(state.copyWith(isPostUploading: false));
  }

  Future openRequests(String? docId, int maxGm, int maxPlayers, context, NotificationBoardCubit cubit) {
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
              color: theme.colorScheme.background,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
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
                            emit(state.copyWith(isCurrentGMButtonSelected: true));
                          },
                          buttonStyle: state.isCurrentGMButtonSelected ? CustomButtonStyles.fillPrimaryTL8 : CustomButtonStyles.fillYellow,
                          buttonTextStyle: state.isCurrentGMButtonSelected ? CustomTextStyles.titleSmallOnErrorContainer : CustomTextStyles.titleSmallCircularStdBluegray70001,
                          height: 45.v,
                          text: 'Current GM 0/$maxGm',
                        ),
                      ),
                      SizedBox(width: 12.h),
                      Expanded(
                        child: CustomElevatedButton(
                          onPressed: () {
                            emit(state.copyWith(isCurrentGMButtonSelected: false));
                          },
                          buttonStyle: !state.isCurrentGMButtonSelected ? CustomButtonStyles.fillPrimaryTL8 : CustomButtonStyles.fillYellow,
                          buttonTextStyle: !state.isCurrentGMButtonSelected ? CustomTextStyles.titleSmallOnErrorContainer : CustomTextStyles.titleSmallCircularStdBluegray70001,
                          height: 45.v,
                          text: 'Current Players 0/$maxPlayers',
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: StreamBuilder<Either<GeneralError, List<RequestModel>>>(
                      stream: cubit.event.getRequests(eventId: docId),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List<RequestModel> data = [];
                          snapshot.data?.fold((l) => null, (r) => data = r);
                          return ListView.separated(
                            separatorBuilder: (
                              context,
                              index,
                            ) =>
                                SizedBox(width: 16.h),
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              return Text(data[index].userName.toString());
                            },
                          );
                        }
                        return ListView.separated(
                          separatorBuilder: (
                            context,
                            index,
                          ) =>
                              SizedBox(width: 16.h),
                          itemCount: 2,
                          itemBuilder: (context, index) {
                            return Container(
                              height: 250,
                              margin: EdgeInsets.symmetric(horizontal: SizeUtils.width * .05, vertical: 10.v),
                              decoration: BoxDecoration(
                                color: theme.colorScheme.background,
                                borderRadius: BorderRadius.circular(
                                  12,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
