import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taverns/presentation/sign_up_successful/signup_success_full_navigator.dart';
import 'package:taverns/presentation/tavern_dasboard/tavern_dashboard_initial_params.dart';
import 'signup_success_full_initial_params.dart';
import 'signup_success_full_state.dart';

class SignupSuccessFullCubit extends Cubit<SignupSuccessFullState> {
  final SignupSuccessFullInitialParams initialParams;
  final SignupSuccessFullNavigator navigator;
  SignupSuccessFullCubit(this.initialParams, this.navigator) : super(SignupSuccessFullState.initial(initialParams: initialParams));


  navigateToTavernDashboard(){
    navigator.openTavernDashboard(TavernDashboardInitialParams());
  }
}