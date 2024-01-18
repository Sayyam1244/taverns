import 'package:taverns/domain/model/event_model.dart';

import 'event_detail_initial_params.dart';

class EventDetailState {
  final EventModel? event;
  final bool isLoading;
  final bool reviewSubmissionLoading;
  final bool reviewSubmitted;
  const EventDetailState({
    this.event,
    required this.reviewSubmitted,
    required this.isLoading,
    required this.reviewSubmissionLoading,
  });

  factory EventDetailState.initial({required EventDetailInitialParams initialParams}) => EventDetailState(
        isLoading: true,
        reviewSubmissionLoading: false,
        reviewSubmitted: true,
      );

  EventDetailState copyWith({
    EventModel? event,
    bool? isLoading,
    bool? reviewSubmissionLoading,
    bool? reviewSubmitted,
  }) =>
      EventDetailState(
        event: event ?? this.event,
        isLoading: isLoading ?? this.isLoading,
        reviewSubmissionLoading: reviewSubmissionLoading ?? this.reviewSubmissionLoading,
        reviewSubmitted: reviewSubmitted ?? this.reviewSubmitted,
      );
}
