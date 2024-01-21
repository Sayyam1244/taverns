import 'search_event_initial_params.dart';

class SearchEventState {

const SearchEventState();

factory SearchEventState.initial({required SearchEventInitialParams initialParams}) => SearchEventState();

SearchEventState copyWith() => const SearchEventState();
}