import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
// ignore: implementation_imports
import 'package:fpdart/src/either.dart';
import 'package:taverns/domain/model/chat_model.dart';
import 'package:taverns/domain/model/chatroom_model.dart';

import '../domain/model/general_model.dart';
import '../domain/model/user_model.dart';
import '../domain/repository/user_repository.dart';

class User implements UserRepository {
  @override
  Future<Either<GeneralError, bool>> createFirestoreUser(
      String uid, UserModel userModel,
      {File? picture}) async {
    try {
      return await FirebaseFirestore.instance
          .collection('Users')
          .where('userName', isEqualTo: userModel.userName)
          .get()
          .then((value) async {
        if (value.docs.isEmpty) {
          if (picture != null) {
            final Reference storageRef =
                FirebaseStorage.instance.ref().child('user_pictures/$uid.jpg');
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
          return left(
              GeneralError('Error', 'Username already taken, Try again!'));
        }
      });
    } catch (e) {
      print('createFirestoreUser=========>' + e.toString());
      return left(
          GeneralError('Error', 'Error happened, Please try again later'));
    }
  }

  @override
  Future<Either<GeneralError, UserModel>> getUser(String uid) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> doc =
          await FirebaseFirestore.instance.collection('Users').doc(uid).get();
      return right(UserModel.fromMap(doc));
    } catch (e) {
      log('getUser=========>' + e.toString());
      return left(
          GeneralError('Error', 'Error happened, Please try again later'));
    }
  }

  @override
  Future<Either<GeneralError, bool>> updateFirestoreUser(
      String uid, UserModel userModel) async {
    try {
      await FirebaseFirestore.instance.collection('Users').doc(uid).set(
          userModel.toMapForUpload(),
          SetOptions(
            merge: true,
          ));
      return right(true);
    } catch (e) {
      log('updateFirestoreUser=========>' + e.toString());

      return left(
          GeneralError('Error', 'Error happened, Please try again later'));
    }
  }

  @override
  Future<Either<GeneralError, List<UserModel>>> getUsersbyType(
      {required String type}) async {
    try {
      QuerySnapshot<Map<String, dynamic>> docs = await FirebaseFirestore
          .instance
          .collection('Users')
          .where('accountType', isEqualTo: type)
          .get();
      return right(docs.docs.map((e) => UserModel.fromMap(e)).toList());
    } catch (e) {
      return left(
          GeneralError('Error', 'Error happened, Please try again later'));
    }
  }

  @override
  Future<Either<GeneralError, List<UserModel>>> getAllUsers() async {
    try {
      QuerySnapshot<Map<String, dynamic>> docs =
          await FirebaseFirestore.instance.collection('Users').get();
      return right(docs.docs.map((e) => UserModel.fromMap(e)).toList());
    } catch (e) {
      return left(
          GeneralError('Error', 'Error happened, Please try again later'));
    }
  }

  @override
  Future<Either<GeneralError, bool>> sendMessage(
      {required ChatModel chatModel, required String chatRoomId}) async {
    try {
      List<String> ls = chatRoomId.split("_");
      log(ls.toString());
      await FirebaseFirestore.instance
          .collection('Chatrooms')
          .doc(chatRoomId)
          .set({
        'docId': chatRoomId,
        'users': ls,
        'last': chatModel.content,
        'lastModified': FieldValue.serverTimestamp(),
      });
      DocumentReference docRef = FirebaseFirestore.instance
          .collection('Chatrooms')
          .doc(chatRoomId)
          .collection('Chats')
          .doc();
      chatModel.docId = docRef.id;
      await docRef.set(chatModel.toMapForUpload());
      return right(true);
    } catch (e) {
      log(e.toString());
      return left(
          GeneralError('Error', 'Error happened, Please try again later'));
    }
  }

  @override
  Stream<Either<GeneralError, List<ChatRoomModel>>> getChats(
      {required String userId}) async* {
    try {
      await for (QuerySnapshot<Map<String, dynamic>> chatDocs
          in FirebaseFirestore.instance
              .collection('Chatrooms')
              .where("users", arrayContains: userId)
              .orderBy('lastModified', descending: true)
              .snapshots()) {
        List<ChatRoomModel> chatrooms = [];
        for (QueryDocumentSnapshot<Map<String, dynamic>> chatroom
            in chatDocs.docs) {
          ChatRoomModel cr = ChatRoomModel.fromMap(chatroom);
          log(cr.users.toString());

          String otherUserId = cr.users?.firstWhere(
                  (element) => element != userId,
                  orElse: () => '') ??
              '';

          if (otherUserId != '') {
            await getUser(otherUserId).then(
              (value) => value.fold(
                (l) => null,
                (r) {
                  cr.otherUsername = r.userName;
                },
              ),
            );
          }
          chatrooms.add(cr);
        }

        yield Right(chatrooms);
      }
    } catch (e) {
      log('=========>' + e.toString());
      yield left(
          GeneralError('Error', 'Error happened, Please try again later'));
    }
  }

  @override
  Stream<Either<GeneralError, List<ChatModel>>> getChatroomChats(
      {required String chatroomId}) async* {
    try {
      await for (QuerySnapshot<Map<String, dynamic>> chatDocs
          in FirebaseFirestore.instance
              .collection('Chatrooms')
              .doc(chatroomId)
              .collection('Chats')
              .orderBy('createdDate', descending: true)
              .snapshots()) {
        List<ChatModel> chats = [];
        for (QueryDocumentSnapshot<Map<String, dynamic>> chat
            in chatDocs.docs) {
          ChatModel cr = ChatModel.fromMap(snapshot: chat);

          chats.add(cr);
        }

        yield Right(chats);
      }
    } catch (e) {
      log('=========>' + e.toString());
      yield left(
          GeneralError('Error', 'Error happened, Please try again later'));
    }
  }
}
