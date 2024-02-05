import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taverns/core/utils/flushbar.dart';
import 'package:taverns/data/db_helper.dart';
import 'package:taverns/domain/model/db_models.dart';
import 'package:taverns/main.dart';
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

  Future<void> import(context) async {
    try {
      FilePickerResult? fl = await FilePicker.platform
          .pickFiles(type: FileType.custom, allowedExtensions: ['json']);
      if (fl != null) {
        File f = File(fl.files.first.path!);
        String fileString = await f.readAsString();
        log(fileString);
        final mappedFile = jsonDecode(fileString);

        if (mappedFile['TYPE'] == 'Character Sheet') {
          Map<String, dynamic>? sysExist = await getIt<DatabaseHelper>()
              .getSystem(title: mappedFile['system']);
          //system check
          if (sysExist == null) {
            getIt<DatabaseHelper>()
                .insertSystem(System(title: mappedFile['system']!).toMap());
            Map<String, dynamic>? sysinMap = await getIt<DatabaseHelper>()
                .getSystem(title: mappedFile['system']);
            //
            System system = System.fromMap(sysinMap!);
            await getIt<DatabaseHelper>().insertCharacter(Character(
                    title: mappedFile['sheetName']!,
                    level: mappedFile['level']!,
                    systemId: system.id!)
                .toMap());
          } else {
            System system = System.fromMap(sysExist!);
            await getIt<DatabaseHelper>().insertCharacter(Character(
                    title: mappedFile['sheetName']!,
                    level: mappedFile['level']!,
                    systemId: system.id!)
                .toMap());
          }
          FlushbarDialogue().showFlushbar(
              context: context, title: 'Database', body: 'Added successfully');
        }
        //compendium check
        if (mappedFile['TYPE'] == 'Compendium') {
          Map<String, dynamic>? catExist = await getIt<DatabaseHelper>()
              .getCategory(title: mappedFile['category']);
          Map<String, dynamic>? subCatExist = await getIt<DatabaseHelper>()
              .getSubCategory(title: mappedFile['subCategory']);
          //check
          if (catExist == null || subCatExist == null) {
            if (catExist == null) {
              getIt<DatabaseHelper>().insertCategory(
                  Category(title: mappedFile['category']!).toMap());
              catExist = await getIt<DatabaseHelper>()
                  .getCategory(title: mappedFile['category']);
            }
            if (subCatExist == null) {
              getIt<DatabaseHelper>().insertSubCategory(SubCategory(
                      title: mappedFile['subCategory']!,
                      categoryId: catExist!['id'])
                  .toMap());
              subCatExist = await getIt<DatabaseHelper>()
                  .getSubCategory(title: mappedFile['subCategory']);
            }

            Category category = Category.fromMap(catExist!);
            SubCategory subCategory = SubCategory.fromMap(subCatExist!);

            await getIt<DatabaseHelper>().insertCompendium(Compendium(
              title: mappedFile['sheetName']!,
              categoryId: category.id!,
              subCategoryId: subCategory.id!,
            ).toMap());
          } else {
            Category category = Category.fromMap(catExist!);
            SubCategory subCategory = SubCategory.fromMap(subCatExist!);

            await getIt<DatabaseHelper>().insertCompendium(Compendium(
              title: mappedFile['sheetName']!,
              categoryId: category.id!,
              subCategoryId: subCategory.id!,
            ).toMap());
          }
          FlushbarDialogue().showFlushbar(
              context: context, title: 'Database', body: 'Added successfully');
        }
      }
    } catch (e) {
      FlushbarDialogue().showErrorFlushbar(
          context: context,
          title: 'Error',
          body: 'Error happened please try again later');
    }
  }
}
