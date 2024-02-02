import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taverns/presentation/character_sheets/character_sheets_initial_params.dart';
import 'package:taverns/presentation/compendium/compendium_initial_params.dart';
import 'package:taverns/presentation/database/database_navigator.dart';
import 'database_initial_params.dart';
import 'database_state.dart';

class DatabaseCubit extends Cubit<DatabaseState> {
  final DatabaseInitialParams initialParams;
  final DatabaseNavigator navigator;
  DatabaseCubit(this.initialParams, this.navigator)
      : super(DatabaseState.initial(initialParams: initialParams));
  navigateToCharacterSheets() =>
      navigator.openCharacterSheets(CharacterSheetsInitialParams());

  void navigateToCompendium() {
    navigator.openCompendium(CompendiumInitialParams());
  }
}
