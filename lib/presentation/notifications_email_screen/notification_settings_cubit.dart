import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taverns/presentation/notifications_email_screen/notification_settings_navigator.dart';
import 'package:taverns/presentation/sign_up_successful/signup_success_full_initial_params.dart';
import 'notification_settings_initial_params.dart';
import 'notification_settings_state.dart';

class NotificationSettingsCubit extends Cubit<NotificationSettingsState> {
  final NotificationSettingsInitialParams initialParams;
  final NotificationSettingsNavigator navigator;
  NotificationSettingsCubit(this.initialParams, this.navigator) : super(NotificationSettingsState.initial(initialParams: initialParams));

  toggleLikeReview() {
    emit(state.copyWith(likeReviews: !state.likeReviews));
  }

  toggleEventsNearMe() {
    emit(state.copyWith(eventsNearMe: !state.eventsNearMe));
  }

  toggleTimeSLot() {
    emit(state.copyWith(timeSlots: !state.timeSlots));
  }

  void navigateToSignupSuccessfulScreen() {
    navigator.openSignupSuccessFull(SignupSuccessFullInitialParams());
  }
}
