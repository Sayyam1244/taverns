import 'package:flutter_bloc/flutter_bloc.dart';
import 'how_to_initial_params.dart';
import 'how_to_state.dart';

class HowToCubit extends Cubit<HowToState> {
  final HowToInitialParams initialParams;

  HowToCubit(this.initialParams) : super(HowToState.initial(initialParams: initialParams));
}