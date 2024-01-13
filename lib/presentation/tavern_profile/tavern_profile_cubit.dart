import 'package:flutter_bloc/flutter_bloc.dart';
import 'tavern_profile_initial_params.dart';
import 'tavern_profile_state.dart';

class TavernProfileCubit extends Cubit<TavernProfileState> {
  final TavernProfileInitialParams initialParams;

  TavernProfileCubit(this.initialParams) : super(TavernProfileState.initial(initialParams: initialParams));
}