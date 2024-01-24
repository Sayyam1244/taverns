import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/src/either.dart';
import 'package:taverns/domain/model/general_model.dart';
import 'package:taverns/domain/model/notification_model.dart';
import 'package:taverns/domain/repository/notification_repository.dart';

class NotificationHelper implements NotificationRepository {
  @override
  Future<void> generateNotification(
      {required NotificationModel notificationModel}) async {
    try {
      DocumentReference<Map<String, dynamic>> docRef =
          FirebaseFirestore.instance.collection('Notifications').doc();

      notificationModel.docId = docRef.id;
      await docRef.set(notificationModel.toMapForUpload());
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Stream<Either<GeneralError, List<NotificationModel>>> getNotifications(
      {required String userId, required int limit}) async* {
    try {
      await for (QuerySnapshot<Map<String, dynamic>> docs in FirebaseFirestore
          .instance
          .collection('Notifications')
          .where('to', isEqualTo: userId)
          .where("createdDate",
              isGreaterThanOrEqualTo:
                  DateTime.now().subtract(Duration(days: 7)))
          .orderBy('createdDate', descending: true)
          .limit(limit)
          .snapshots()) {
        List<NotificationModel> notifications = [];
        for (QueryDocumentSnapshot<Map<String, dynamic>> doc in docs.docs) {
          notifications.add(NotificationModel.fromMap(doc));
        }

        yield Right(notifications);
      }
    } catch (e) {
      log('getEvents=========>' + e.toString());
      yield left(
          GeneralError('Error', 'Error happened, Please try again later'));
    }
  }
}
