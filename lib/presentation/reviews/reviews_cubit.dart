import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taverns/domain/repository/events_repository.dart';
import '../../core/utils/flushbar.dart';
import 'reviews_initial_params.dart';
import 'reviews_state.dart';

class ReviewsCubit extends Cubit<ReviewsState> {
  final ReviewsInitialParams initialParams;
  final EventRepository event;
  ReviewsCubit(this.initialParams, this.event) : super(ReviewsState.initial(initialParams: initialParams));

  getReviews(context) async {
    log("uid " + initialParams.userId.toString());
    await event.getUserReviews(userId: initialParams.userId).then(
          (value) => value.fold(
            (l) => FlushbarDialogue().showErrorFlushbar(context: context, title: l.title, body: l.message),
            (r) => emit(state.copyWith(reviews: r)),
          ),
        );
    emit(state.copyWith(isLoading: false));
  }
}
