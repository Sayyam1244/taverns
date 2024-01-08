import 'package:taverns/domain/model/user_model.dart';

import 'tavern_dashboard_initial_params.dart';

class TavernDashboardState {
  final int currentIndex;
  final UserModel user;
  final bool isloading;
  const TavernDashboardState({required this.currentIndex, required this.user, required this.isloading});

  factory TavernDashboardState.initial({required TavernDashboardInitialParams initialParams}) => TavernDashboardState(currentIndex: 1, user: UserModel(), isloading: true);

  TavernDashboardState copyWith({
    int? currentIndex,
    UserModel? user,
    bool? isloading,
  }) =>
      TavernDashboardState(
        currentIndex: currentIndex ?? this.currentIndex,
        user: user ?? this.user,
        isloading: isloading ?? this.isloading,
      );
}
