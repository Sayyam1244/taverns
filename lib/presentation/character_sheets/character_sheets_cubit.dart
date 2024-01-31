import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taverns/data/db_helper.dart';
import 'package:taverns/domain/model/db_models.dart';
import 'package:taverns/main.dart';
import 'character_sheets_initial_params.dart';
import 'character_sheets_state.dart';

class CharacterSheetsCubit extends Cubit<CharacterSheetsState> {
  final CharacterSheetsInitialParams initialParams;

  CharacterSheetsCubit(this.initialParams)
      : super(CharacterSheetsState.initial(initialParams: initialParams));
  getCharacterSheets({int? sysId}) async {
    List<Character> cr =
        await getIt<DatabaseHelper>().getAllCharacters(systemId: sysId).then(
              (value) => value.map((e) {
                return Character.fromMap(e);
              }).toList(),
            );
    for (var i = 0; i < cr.length; i++) {
      await getIt<DatabaseHelper>().getSystem(cr[i].systemId).then(
            (value) => cr[i].injectSystem(
              System.fromMap(value!),
            ),
          );
    }
    emit(
      state.copyWith(characters: cr.reversed.toList(), isloading: false),
    );
  }

  getSystems() async {
    await getIt<DatabaseHelper>().getAllSystems().then(
          (value) => emit(
            state.copyWith(
              systems: value.map((e) => System.fromMap(e)).toList(),
            ),
          ),
        );
  }
}
