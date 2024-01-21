import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taverns/core/utils/flushbar.dart';
import 'package:taverns/domain/model/review_model.dart';
import 'package:taverns/domain/repository/auth_repository.dart';
import 'package:taverns/domain/repository/events_repository.dart';
import 'event_detail_initial_params.dart';
import 'event_detail_state.dart';

class EventDetailCubit extends Cubit<EventDetailState> {
  final EventDetailInitialParams initialParams;
  final EventRepository event;
  final AuthRepository _auth;
  EventDetailCubit(this.initialParams, this.event, this._auth)
      : super(
          EventDetailState.initial(
            initialParams: initialParams,
          ),
        );
  getEvent(context) {
    event.getEvent(eventId: initialParams.docId, getUser: true).then((value) {
      return value.fold(
        (l) => FlushbarDialogue().showErrorFlushbar(context: context, title: l.title, body: l.message),
        (r) async {
          await checkReviewStatus();
          emit(state.copyWith(event: r, isLoading: false));
        },
      );
    });
  }

  void submitReview({required String text, required int rating, context}) async {
    emit(state.copyWith(isLoading: true));
    await event
        .submitReviewToEvent(
          reviewModel: ReviewModel(
            userId: _auth.currentUser().uid,
            eventId: initialParams.docId,
            review: text,
            stars: rating,
            hostId: state.event!.userId,
            name: state.event!.user!.userName,
          ),
        )
        .then(
          (value) => value.fold(
            (l) => FlushbarDialogue().showErrorFlushbar(context: context, title: l.title, body: l.message),
            (r) => FlushbarDialogue().showFlushbar(context: context, title: 'Review', body: 'Review posted successfully'),
          ),
        );
    await checkReviewStatus();
    emit(state.copyWith(isLoading: false));
  }

  checkReviewStatus() async {
    event.checkIsReviewPosted(eventId: initialParams.docId, userId: _auth.currentUser().uid).then(
          (value) => value.fold(
            (l) => emit(state.copyWith(reviewSubmitted: true)),
            (r) => emit(state.copyWith(reviewSubmitted: r)),
          ),
        );
  }
}
