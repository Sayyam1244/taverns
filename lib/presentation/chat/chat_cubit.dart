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
import 'chat_initial_params.dart';
import 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final ChatInitialParams initialParams;
  final UserRepository user;
  final AuthRepository auth;
  ChatCubit(this.initialParams, this.user, this.auth)
      : super(ChatState.initial(initialParams: initialParams));

  saveInDb({
    required ChatModel chatModel,
    required BuildContext context,
  }) async {
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

    if (chatModel.TYPE == 'COMPENDIUM') {}
  }
}
