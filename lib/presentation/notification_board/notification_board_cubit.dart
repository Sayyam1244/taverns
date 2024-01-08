import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taverns/core/utils/datetime_picker.dart';
import 'package:taverns/domain/model/event_model.dart';
import 'package:taverns/domain/repository/auth_repository.dart';
import 'package:taverns/domain/repository/events_repository.dart';
import 'package:taverns/domain/repository/user_repository.dart';
import 'package:taverns/presentation/notification_board/notification_board_navigator.dart';
import '../../core/utils/flushbar.dart';
import 'notification_board_initial_params.dart';
import 'notification_board_state.dart';

class NotificationBoardCubit extends Cubit<NotificationBoardState> {
  final NotificationBoardInitialParams initialParams;
  final NotificationBoardNavigator navigator;
  final AuthRepository _auth;
  final UserRepository _user;
  final EventRepository _event;
  NotificationBoardCubit(this.initialParams, this.navigator, this._auth, this._user, this._event)
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

  Future<void> postEvent(BuildContext context) async {
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
    await _event.postEvent(event: eventModel).then(
          (value) => value.fold(
            (l) => FlushbarDialogue().showErrorFlushbar(context: context, title: l.title, body: l.message),
            (r) {
              FlushbarDialogue().showFlushbar(context: context, title: 'Event Uploaded', body: 'Your Post has been uploaded successfully');
            },
          ),
        );
    emit(state.copyWith(isPostUploading: false));
  }
}
