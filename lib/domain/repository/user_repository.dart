import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:taverns/domain/model/general_model.dart';

import '../model/user_model.dart';

abstract class UserRepository {
  Future<Either<GeneralError, bool>> createFirestoreUser(String uid, UserModel userModel, {File? picture});
  Future<Either<GeneralError, bool>> updateFirestoreUser(String uid, UserModel userModel);
  Future<Either<GeneralError, UserModel>> getUser(String uid);
}
