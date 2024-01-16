import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taverns/core/utils/flushbar.dart';
import 'package:taverns/domain/repository/auth_repository.dart';
import 'package:taverns/domain/repository/events_repository.dart';
import 'event_detail_initial_params.dart';
import 'event_detail_state.dart';

class EventDetailCubit extends Cubit<EventDetailState> {
  final EventDetailInitialParams initialParams;
  final EventRepository _event;
  final AuthRepository _auth;
  EventDetailCubit(this.initialParams, this._event, this._auth)
      : super(
          EventDetailState.initial(
            initialParams: initialParams,
          ),
        );
  getEvent(context) {
    _event.getEvent(eventId: initialParams.docId, getUser: true).then((value) {
      return value.fold(
        (l) => FlushbarDialogue().showErrorFlushbar(context: context, title: l.title, body: l.message),
        (r) {
          emit(state.copyWith(event: r, isLoading: false));
        },
      );
    });
  }
}
