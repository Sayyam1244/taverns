import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taverns/presentation/enable_location/enable_location_initial_params.dart';
import 'package:taverns/presentation/signup_completion/signup_completion_navigator.dart';
import 'signup_completion_initial_params.dart';
import 'signup_completion_state.dart';

class SignupCompletionCubit extends Cubit<SignupCompletionState> {
  final SignupCompletionInitialParams initialParams;
  final SignupCompletionNavigator navigator;
  SignupCompletionCubit(this.initialParams, this.navigator) : super(SignupCompletionState.initial(initialParams: initialParams));

  navigateToEnableLocationScreen(){
    navigator.openEnableLocation(EnableLocationInitialParams());
  }
}
