import 'package:taverns/domain/model/user_model.dart';

import 'tavern_dashboard_initial_params.dart';

class TavernDashboardState {
  final int currentIndex;
  final UserModel user;
  const TavernDashboardState({required this.currentIndex, required this.user});

  factory TavernDashboardState.initial({required TavernDashboardInitialParams initialParams}) => TavernDashboardState(currentIndex: 1, user: UserModel());

  TavernDashboardState copyWith({
    int? currentIndex,
    UserModel? user,
  }) =>
      TavernDashboardState(
        currentIndex: currentIndex ?? this.currentIndex,
        user: user ?? this.user,
      );
}
