import 'package:flutter_bloc/flutter_bloc.dart';
import 'search_user_initial_params.dart';
import 'search_user_state.dart';

class SearchUserCubit extends Cubit<SearchUserState> {
  final SearchUserInitialParams initialParams;

  SearchUserCubit(this.initialParams) : super(SearchUserState.initial(initialParams: initialParams));
}