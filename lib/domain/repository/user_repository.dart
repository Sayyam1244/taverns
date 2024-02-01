import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:taverns/domain/model/chat_model.dart';
import 'package:taverns/domain/model/chatroom_model.dart';
import 'package:taverns/domain/model/general_model.dart';

import '../model/user_model.dart';

abstract class UserRepository {
  Future<Either<GeneralError, bool>> createFirestoreUser(
      String uid, UserModel userModel,
      {File? picture});

  Future<Either<GeneralError, bool>> updateFirestoreUser(
      String uid, UserModel userModel);
  Future<Either<GeneralError, UserModel>> getUser(String uid);
  Future<Either<GeneralError, List<UserModel>>> getAllUsers();
  Future<Either<GeneralError, List<UserModel>>> getUsersbyType(
      {required String type});
  Future<Either<GeneralError, bool>> sendMessage(
      {required ChatModel chatModel, required String chatRoomId});
  Stream<Either<GeneralError, List<ChatRoomModel>>> getChats(
      {required String userId});
  Stream<Either<GeneralError, List<ChatModel>>> getChatroomChats(
      {required String chatroomId});
}
