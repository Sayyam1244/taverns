import 'package:taverns/domain/model/db_models.dart';

import 'character_sheets_initial_params.dart';

class CharacterSheetsState {
  final List<Character> characters;
  final List<System> systems;
  final bool isloading;
  CharacterSheetsState(
      {required this.characters,
      required this.systems,
      required this.isloading});

  factory CharacterSheetsState.initial(
          {required CharacterSheetsInitialParams initialParams}) =>
      CharacterSheetsState(characters: [], systems: [], isloading: true);

  CharacterSheetsState copyWith(
          {List<Character>? characters,
          bool? isloading,
          List<System>? systems}) =>
      CharacterSheetsState(
        isloading: isloading ?? this.isloading,
        characters: characters ?? this.characters,
        systems: systems ?? this.systems,
      );
}
