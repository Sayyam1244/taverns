import 'package:flutter_bloc/flutter_bloc.dart';
import 'faqs_initial_params.dart';
import 'faqs_state.dart';

class FaqsCubit extends Cubit<FaqsState> {
  final FaqsInitialParams initialParams;

  FaqsCubit(this.initialParams) : super(FaqsState.initial(initialParams: initialParams));
}