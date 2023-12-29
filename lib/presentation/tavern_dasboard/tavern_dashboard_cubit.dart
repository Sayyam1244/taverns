import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taverns/presentation/tavern_dasboard/tavern_dashboard_navigator.dart';
import 'tavern_dashboard_initial_params.dart';
import 'tavern_dashboard_state.dart';

class TavernDashboardCubit extends Cubit<TavernDashboardState> {
  final TavernDashboardInitialParams initialParams;
  final TavernDashboardNavigator navigator;
  TavernDashboardCubit(this.initialParams, this.navigator) : super(TavernDashboardState.initial(initialParams: initialParams));
}