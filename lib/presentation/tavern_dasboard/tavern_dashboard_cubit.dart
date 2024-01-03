import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taverns/domain/repository/auth_repository.dart';
import 'package:taverns/domain/repository/user_repository.dart';
import 'package:taverns/presentation/tavern_dasboard/tavern_dashboard_navigator.dart';
import 'tavern_dashboard_initial_params.dart';
import 'tavern_dashboard_state.dart';

class TavernDashboardCubit extends Cubit<TavernDashboardState> {
  final TavernDashboardInitialParams initialParams;
  final TavernDashboardNavigator navigator;
  final AuthRepository _auth;
  final UserRepository _user;
  TavernDashboardCubit(this.initialParams, this.navigator, this._auth, this._user)
      : super(
          TavernDashboardState.initial(
            initialParams: initialParams,
          ),
        );
}
