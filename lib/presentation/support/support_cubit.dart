import 'package:flutter_bloc/flutter_bloc.dart';
import 'support_initial_params.dart';
import 'support_state.dart';

class SupportCubit extends Cubit<SupportState> {
  final SupportInitialParams initialParams;

  SupportCubit(this.initialParams) : super(SupportState.initial(initialParams: initialParams));
}