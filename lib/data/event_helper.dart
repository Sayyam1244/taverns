import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/src/either.dart';
import 'package:taverns/domain/model/event_model.dart';
import 'package:taverns/domain/model/general_model.dart';
import 'package:taverns/domain/model/request_model.dart';
import 'package:taverns/domain/model/user_model.dart';
import 'package:taverns/domain/repository/events_repository.dart';

class EventHelper implements EventRepository {
  @override
  Future<Either<GeneralError, bool>> postEvent({required EventModel event}) async {
    try {
      DocumentReference<Map<String, dynamic>> docRef = FirebaseFirestore.instance.collection('Events').doc();
      event.docId = docRef.id;
      await docRef.set(event.toMapForUpload());
      return right(true);
    } catch (e) {
      log('postEvent=========>' + e.toString());
      return left(GeneralError('Error', 'Error happened, Please try again later'));
    }
  }

  @override
  Stream<Either<GeneralError, List<EventModel>>> getEvents({required bool getUser, String? userId, bool? fromTodayDate, required int limit}) async* {
    try {
      await for (QuerySnapshot<Map<String, dynamic>> eventsDocs in userId != null
          ? (fromTodayDate != null || fromTodayDate == true)
              ? FirebaseFirestore.instance
                  .collection('Events')
                  .where("eventDatetime", isGreaterThanOrEqualTo: DateTime.now())
                  .where("userId", isEqualTo: userId)
                  .limit(limit)
                  .snapshots()
              : FirebaseFirestore.instance.collection('Events').where("userId", isEqualTo: userId).limit(limit).snapshots()
          : FirebaseFirestore.instance.collection('Events').where("eventDatetime", isGreaterThanOrEqualTo: DateTime.now()).limit(limit).snapshots()) {
        List<EventModel> events = [];
        for (QueryDocumentSnapshot<Map<String, dynamic>> eventDoc in eventsDocs.docs) {
          EventModel event = EventModel.fromMap(eventDoc);
          if (getUser) {
            DocumentSnapshot<Map<String, dynamic>> userDoc = await FirebaseFirestore.instance.collection('Users').doc(event.userId).get();
            if (userDoc.exists) {
              event.injectUser(UserModel.fromMap(userDoc));
            }
          }
          events.add(event);
        }

        yield Right(events);
      }
    } catch (e) {
      log('getEvents=========>' + e.toString());
      yield left(GeneralError('Error', 'Error happened, Please try again later'));
    }
  }

  @override
  Stream<Either<GeneralError, List<RequestModel>>> getRequests({String? eventId}) async* {
    try {
      await for (QuerySnapshot<Map<String, dynamic>> requestDocs
          in FirebaseFirestore.instance.collection('Requests').where("eventId", isEqualTo: eventId).where("isApproved", isEqualTo: null).snapshots()) {
        List<RequestModel> requests = requestDocs.docs.map((e) => RequestModel.fromMap(e)).toList();

        yield Right(requests);
      }
    } catch (e) {
      log('getEvents=========>' + e.toString());
      yield left(GeneralError('Error', 'Error happened, Please try again later'));
    }
  }

  @override
  Future<Either<GeneralError, EventModel>> getEvent({String? eventId, required bool getUser}) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> doc = await FirebaseFirestore.instance.collection('Events').doc(eventId!).get();
      EventModel event = EventModel.fromMap(doc);
      if (getUser) {
        DocumentSnapshot<Map<String, dynamic>> userDoc = await FirebaseFirestore.instance.collection('Users').doc(event.userId).get();

        event.injectUser(UserModel.fromMap(userDoc));
      }
      return right(event);
    } catch (e) {
      return left(GeneralError('Error', 'Error happened, Please try again later'));
    }
  }
}
