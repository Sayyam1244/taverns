import 'database_initial_params.dart';

class DatabaseState {

const DatabaseState();

factory DatabaseState.initial({required DatabaseInitialParams initialParams}) => DatabaseState();

DatabaseState copyWith() => const DatabaseState();
}