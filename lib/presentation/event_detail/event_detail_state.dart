import 'package:taverns/domain/model/event_model.dart';

import 'event_detail_initial_params.dart';

class EventDetailState {
  final EventModel? event;
  final bool isLoading;
  final bool reviewSubmissionLoading;
  const EventDetailState({this.event, required this.isLoading, required this.reviewSubmissionLoading});

  factory EventDetailState.initial({required EventDetailInitialParams initialParams}) => EventDetailState(
        isLoading: true,
        reviewSubmissionLoading: false,
      );

  EventDetailState copyWith({
    EventModel? event,
    bool? isLoading,
    bool? reviewSubmissionLoading,
  }) =>
      EventDetailState(
        event: event ?? this.event,
        isLoading: isLoading ?? this.isLoading,
        reviewSubmissionLoading: reviewSubmissionLoading ?? this.reviewSubmissionLoading,
      );
}
