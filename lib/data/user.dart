import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
// ignore: implementation_imports
import 'package:fpdart/src/either.dart';

import '../domain/model/general_model.dart';
import '../domain/model/user_model.dart';
import '../domain/repository/user_repository.dart';

class User implements UserRepository {
  @override
  Future<Either<GeneralError, bool>> createFirestoreUser(String uid, UserModel userModel, {File? picture}) async {
    try {
      return await FirebaseFirestore.instance.collection('Users').where('userName', isEqualTo: userModel.userName).get().then((value) async {
        if (value.docs.isEmpty) {
          if (picture != null) {
            final Reference storageRef = FirebaseStorage.instance.ref().child('user_pictures/$uid.jpg');
            await storageRef.putFile(picture);
            final String downloadUrl = await storageRef.getDownloadURL();
            userModel.profilePicture = downloadUrl;
          }
          //
          userModel.docId = uid;
          await FirebaseFirestore.instance.collection('Users').doc(uid).set(
              userModel.toMapForUpload(),
              SetOptions(
                merge: true,
              ));
          return right(true);
        } else {
          return left(GeneralError('Error', 'Username already taken, Try again!'));
        }
      });
    } catch (e) {
      print('createFirestoreUser=========>' + e.toString());
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

  @override
  Future<Either<GeneralError, bool>> updateFirestoreUser(String uid, UserModel userModel) async {
    try {
      await FirebaseFirestore.instance.collection('Users').doc(uid).set(
          userModel.toMapForUpload(),
          SetOptions(
            merge: true,
          ));
      return right(true);
    } catch (e) {
      log('updateFirestoreUser=========>' + e.toString());

      return left(GeneralError('Error', 'Error happened, Please try again later'));
    }
  }
}
