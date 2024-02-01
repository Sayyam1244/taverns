import 'package:taverns/domain/model/user_model.dart';

import 'tavern_dashboard_initial_params.dart';

class TavernDashboardState {
  final int currentIndex;
  final UserModel user;
  final bool isloading;
  DateTime focusedDay;
  DateTime selectedDay;
  final int stars;
  final int reviewCount;
  TavernDashboardState(
      {required this.currentIndex,
      required this.user,
      required this.isloading,
      required this.stars,
      required this.reviewCount,
      required this.focusedDay,
      required this.selectedDay});

  factory TavernDashboardState.initial(
          {required TavernDashboardInitialParams initialParams}) =>
      TavernDashboardState(
        currentIndex: 2,
        user:
            UserModel(userName: '', accountType: 'Player', businessNumber: ''),
        isloading: true,
        selectedDay: DateTime.now(),
        focusedDay: DateTime.now(),
        reviewCount: 0,
        stars: 0,
      );

  TavernDashboardState copyWith({
    int? currentIndex,
    UserModel? user,
    bool? isloading,
    DateTime? selectedDay,
    DateTime? focusedDay,
    int? stars,
    int? reviewCount,
  }) =>
      TavernDashboardState(
        currentIndex: currentIndex ?? this.currentIndex,
        user: user ?? this.user,
        isloading: isloading ?? this.isloading,
        focusedDay: focusedDay ?? this.focusedDay,
        selectedDay: selectedDay ?? this.selectedDay,
        reviewCount: reviewCount ?? this.reviewCount,
        stars: stars ?? this.stars,
      );
}
