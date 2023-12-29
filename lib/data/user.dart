import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
// ignore: implementation_imports
import 'package:fpdart/src/either.dart';

import '../domain/model/general_model.dart';
import '../domain/model/user_model.dart';
import '../domain/repository/user_repository.dart';

class User implements UserRepository {
  @override
  Future<Either<GeneralError, bool>> createFirestoreUser(String uid, UserModel userModel) async {
    try {
      await FirebaseFirestore.instance.collection('Users').doc(uid).set(userModel.toMapForUpload());
      return right(true);
    } catch (e) {
      log('createFirestoreUser=========>' + e.toString());
      return left(GeneralError('Error', 'Error happened, Please try again later'));
    }
  }

  @override
  Future<Either<GeneralError, UserModel>> getUser(String uid) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> doc = await FirebaseFirestore.instance.collection('Users').doc(uid).get();
      return right(UserModel.fromMap(doc));
    } catch (e) {
      log('getUser=========>' + e.toString());
      return left(GeneralError('Error', 'Error happened, Please try again later'));
    }
  }
}
