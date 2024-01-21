import 'search_user_initial_params.dart';

class SearchUserState {

const SearchUserState();

factory SearchUserState.initial({required SearchUserInitialParams initialParams}) => SearchUserState();

SearchUserState copyWith() => const SearchUserState();
}