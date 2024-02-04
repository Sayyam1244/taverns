import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';
import 'package:taverns/core/utils/flushbar.dart';
import 'package:taverns/data/db_helper.dart';
import 'package:taverns/domain/model/db_models.dart';
import 'package:taverns/main.dart';
import 'package:taverns/presentation/chat_list/chat_list_initial_params.dart';
import 'package:taverns/presentation/compendium/compendium_navigator.dart';
import 'compendium_initial_params.dart';
import 'compendium_state.dart';

class CompendiumCubit extends Cubit<CompendiumState> {
  final CompendiumInitialParams initialParams;
  final CompendiumNavigator navigator;

  CompendiumCubit(this.initialParams, this.navigator)
      : super(CompendiumState.initial(initialParams: initialParams));

  getCompendiums({int? catId, int? subCatId}) async {
    emit(state.copyWith(isloading: true));
    List<Compendium> cp = await getIt<DatabaseHelper>()
        .getAllCompendium(catId: catId, subCatId: subCatId)
        .then(
      (value) {
        return value.map((e) {
          return Compendium.fromMap(e);
        }).toList();
      },
    );

    for (var i = 0; i < cp.length; i++) {
      await getIt<DatabaseHelper>().getCategory(id: cp[i].categoryId).then(
            (value) => cp[i].category = Category.fromMap(value!),
          );
      await getIt<DatabaseHelper>()
          .getSubCategory(id: cp[i].subCategoryId)
          .then(
            (value) => cp[i].subCategory = SubCategory.fromMap(value!),
          );
    }
    List<Category> cat = await getIt<DatabaseHelper>().getAllCategories().then(
          (value) => value.map((e) {
            return Category.fromMap(e);
          }).toList(),
        );

    List<SubCategory> subCat =
        await getIt<DatabaseHelper>().getAllSubCategories().then(
              (value) => value.map((e) {
                return SubCategory.fromMap(e);
              }).toList(),
            );
    cat.add(Category(title: 'All'));
    subCat.add(SubCategory(title: 'All', categoryId: 0));
    emit(
      state.copyWith(
          compendiums: cp.reversed.toList(),
          categories: cat,
          subCategories: subCat,
          isloading: false),
    );
  }

  void navigateToShare(Compendium data) {
    navigator
        .openChatList(ChatListInitialParams(toSend: false, compendium: data));
  }

  Future<void> share(Map data, BuildContext context) async {
    try {
      final String filename = DateTime.now().toString();
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/$filename.json');

      final jsonString = jsonEncode(data);
      await file.writeAsString(jsonString);
      await Share.shareFiles([file.path], text: 'Sharing Sheet');
    } catch (e) {
      log(e.toString());
      FlushbarDialogue().showErrorFlushbar(
          context: context,
          title: 'Error',
          body: 'Error happened, Please try again later');
    }
  }
}
