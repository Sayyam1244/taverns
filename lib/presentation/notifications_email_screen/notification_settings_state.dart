import 'notification_settings_initial_params.dart';

class NotificationSettingsState {
  final bool likeReviews;
  final bool eventsNearMe;
  final bool timeSlots;

  const NotificationSettingsState({
    required this.likeReviews,
    required this.eventsNearMe,
    required this.timeSlots,
  });

  factory NotificationSettingsState.initial({required NotificationSettingsInitialParams initialParams}) => NotificationSettingsState(
        likeReviews: true,
        eventsNearMe: true,
        timeSlots: true,
      );

  NotificationSettingsState copyWith({
    bool? likeReviews,
    bool? eventsNearMe,
    bool? timeSlots,
  }) =>
      NotificationSettingsState(
        eventsNearMe: eventsNearMe ?? this.eventsNearMe,
        likeReviews: likeReviews ?? this.likeReviews,
        timeSlots: timeSlots ?? this.timeSlots,
      );
}
