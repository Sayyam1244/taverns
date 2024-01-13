import 'package:flutter_bloc/flutter_bloc.dart';
import 'search_event_initial_params.dart';
import 'search_event_state.dart';

class SearchEventCubit extends Cubit<SearchEventState> {
  final SearchEventInitialParams initialParams;

  SearchEventCubit(this.initialParams) : super(SearchEventState.initial(initialParams: initialParams));
}