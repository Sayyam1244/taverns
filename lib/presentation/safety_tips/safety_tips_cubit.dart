import 'package:flutter_bloc/flutter_bloc.dart';
import 'safety_tips_initial_params.dart';
import 'safety_tips_state.dart';

class SafetyTipsCubit extends Cubit<SafetyTipsState> {
  final SafetyTipsInitialParams initialParams;

  SafetyTipsCubit(this.initialParams) : super(SafetyTipsState.initial(initialParams: initialParams));
}