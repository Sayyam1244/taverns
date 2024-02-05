import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taverns/core/utils/flushbar.dart';
import 'package:taverns/data/db_helper.dart';
import 'package:taverns/domain/model/chat_model.dart';
import 'package:taverns/domain/model/db_models.dart';
import 'package:taverns/domain/repository/auth_repository.dart';
import 'package:taverns/domain/repository/user_repository.dart';
import 'package:taverns/main.dart';
import 'package:taverns/presentation/chat/chat_navigator.dart';
import 'package:taverns/presentation/tavern_profile/tavern_profile_initial_params.dart';
import 'chat_initial_params.dart';
import 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final ChatInitialParams initialParams;
  final ChatNavigator navigator;
  final UserRepository user;
  final AuthRepository auth;
  ChatCubit(this.initialParams, this.user, this.auth, this.navigator)
      : super(ChatState.initial(initialParams: initialParams));

  saveInDb({
    required ChatModel chatModel,
    required BuildContext context,
  }) async {
    log(chatModel.TYPE.toString());

    if (chatModel.TYPE == 'Character Sheet') {
      Map<String, dynamic>? sysExist =
          await getIt<DatabaseHelper>().getSystem(title: chatModel.system);
      //system check
      if (sysExist == null) {
        getIt<DatabaseHelper>()
            .insertSystem(System(title: chatModel.system!).toMap());
        Map<String, dynamic>? sysinMap =
            await getIt<DatabaseHelper>().getSystem(title: chatModel.system);
        System system = System.fromMap(sysinMap!);
        await getIt<DatabaseHelper>().insertCharacter(Character(
                title: chatModel.sheetName!,
                level: chatModel.level!,
                systemId: system.id!)
            .toMap());
      } else {
        System system = System.fromMap(sysExist!);
        await getIt<DatabaseHelper>().insertCharacter(Character(
                title: chatModel.sheetName!,
                level: chatModel.level!,
                systemId: system.id!)
            .toMap());
      }
      FlushbarDialogue().showFlushbar(
          context: context, title: 'Database', body: 'Added successfully');
    }

    if (chatModel.TYPE == 'Compendium') {
      log(chatModel.category.toString());
      log(chatModel.subCategory.toString());
      log(chatModel.sheetName.toString());
      Map<String, dynamic>? catExist =
          await getIt<DatabaseHelper>().getCategory(title: chatModel.category);
      Map<String, dynamic>? subCatExist = await getIt<DatabaseHelper>()
          .getSubCategory(title: chatModel.subCategory);
      //check
      if (catExist == null || subCatExist == null) {
        if (catExist == null) {
          getIt<DatabaseHelper>()
              .insertCategory(Category(title: chatModel.category!).toMap());
          catExist = await getIt<DatabaseHelper>()
              .getCategory(title: chatModel.category);
        }
        if (subCatExist == null) {
          getIt<DatabaseHelper>().insertSubCategory(SubCategory(
                  title: chatModel.subCategory!, categoryId: catExist!['id'])
              .toMap());
          subCatExist = await getIt<DatabaseHelper>()
              .getSubCategory(title: chatModel.subCategory);
        }

        Category category = Category.fromMap(catExist!);
        SubCategory subCategory = SubCategory.fromMap(subCatExist!);

        await getIt<DatabaseHelper>().insertCompendium(Compendium(
          title: chatModel.sheetName!,
          categoryId: category.id!,
          subCategoryId: subCategory.id!,
        ).toMap());
      } else {
        Category category = Category.fromMap(catExist!);
        SubCategory subCategory = SubCategory.fromMap(subCatExist!);

        await getIt<DatabaseHelper>().insertCompendium(Compendium(
          title: chatModel.sheetName!,
          categoryId: category.id!,
          subCategoryId: subCategory.id!,
        ).toMap());
      }
      FlushbarDialogue().showFlushbar(
          context: context, title: 'Database', body: 'Added successfully');
    }
  }

  void naviateToUserDetailScreen(String otherUid) {
    navigator.openTavernProfile(TavernProfileInitialParams(otherUid, false));
  }
}
