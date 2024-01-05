import 'tavern_dashboard_initial_params.dart';

class TavernDashboardState {
  final int currentIndex;
  const TavernDashboardState({required this.currentIndex});

  factory TavernDashboardState.initial(
          {required TavernDashboardInitialParams initialParams}) =>
      TavernDashboardState(
        currentIndex: 3,
      );

  TavernDashboardState copyWith({
    int? currentIndex,
  }) =>
      TavernDashboardState(
        currentIndex: currentIndex ?? this.currentIndex,
      );
}
