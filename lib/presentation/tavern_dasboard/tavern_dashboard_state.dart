import 'package:taverns/domain/model/user_model.dart';

import 'tavern_dashboard_initial_params.dart';

class TavernDashboardState {
  final int currentIndex;
  final UserModel user;
  final bool isloading;
  DateTime focusedDay;
  DateTime selectedDay;
  TavernDashboardState(
      {required this.currentIndex,
      required this.user,
      required this.isloading,
      required this.focusedDay,
      required this.selectedDay});

  factory TavernDashboardState.initial(
          {required TavernDashboardInitialParams initialParams}) =>
      TavernDashboardState(
        currentIndex: 0,
        user: UserModel(),
        isloading: true,
        selectedDay: DateTime.now(),
        focusedDay: DateTime.now(),
      );

  TavernDashboardState copyWith({
    int? currentIndex,
    UserModel? user,
    bool? isloading,
    DateTime? selectedDay,
    DateTime? focusedDay,
  }) =>
      TavernDashboardState(
        currentIndex: currentIndex ?? this.currentIndex,
        user: user ?? this.user,
        isloading: isloading ?? this.isloading,
        focusedDay: focusedDay ?? this.focusedDay,
        selectedDay: selectedDay ?? this.selectedDay,
      );
}
