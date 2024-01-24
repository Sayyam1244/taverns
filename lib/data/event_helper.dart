import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/src/either.dart';
import 'package:taverns/domain/model/event_model.dart';
import 'package:taverns/domain/model/general_model.dart';
import 'package:taverns/domain/model/request_model.dart';
import 'package:taverns/domain/model/review_model.dart';
import 'package:taverns/domain/model/user_model.dart';
import 'package:taverns/domain/repository/events_repository.dart';

class EventHelper implements EventRepository {
  @override
  Future<Either<GeneralError, bool>> postEvent(
      {required EventModel event}) async {
    try {
      DocumentReference<Map<String, dynamic>> docRef =
          FirebaseFirestore.instance.collection('Events').doc();
      event.docId = docRef.id;
      await docRef.set(event.toMapForUpload());
      return right(true);
    } catch (e) {
      log('postEvent=========>' + e.toString());
      return left(
          GeneralError('Error', 'Error happened, Please try again later'));
    }
  }

  @override
  Stream<Either<GeneralError, List<EventModel>>> getEvents(
      {required bool getUser,
      String? userId,
      bool? fromTodayDate,
      required int limit}) async* {
    try {
      await for (QuerySnapshot<Map<String, dynamic>> eventsDocs in userId !=
              null
          ? (fromTodayDate != null || fromTodayDate == true)
              ? FirebaseFirestore.instance
                  .collection('Events')
                  .where("eventDatetime",
                      isGreaterThanOrEqualTo: DateTime.now())
                  .where("userId", isEqualTo: userId)
                  .limit(limit)
                  .snapshots()
              : FirebaseFirestore.instance
                  .collection('Events')
                  .where("userId", isEqualTo: userId)
                  .limit(limit)
                  .snapshots()
          : FirebaseFirestore.instance
              .collection('Events')
              .where("eventDatetime", isGreaterThanOrEqualTo: DateTime.now())
              .where('isApproved', isEqualTo: true)
              .limit(limit)
              .snapshots()) {
        List<EventModel> events = [];
        for (QueryDocumentSnapshot<Map<String, dynamic>> eventDoc
            in eventsDocs.docs) {
          EventModel event = EventModel.fromMap(eventDoc);
          if (getUser) {
            DocumentSnapshot<Map<String, dynamic>> userDoc =
                await FirebaseFirestore.instance
                    .collection('Users')
                    .doc(event.userId)
                    .get();
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
      yield left(
          GeneralError('Error', 'Error happened, Please try again later'));
    }
  }

  @override
  Stream<Either<GeneralError, List<RequestModel>>> getRequests(
      {String? eventId}) async* {
    try {
      await for (QuerySnapshot<Map<String, dynamic>> requestDocs
          in FirebaseFirestore.instance
              .collection('Requests')
              .where("eventId", isEqualTo: eventId)
              .snapshots()) {
        List<RequestModel> requests =
            requestDocs.docs.map((e) => RequestModel.fromMap(e)).toList();
        yield Right(requests);
      }
    } catch (e) {
      log('getEvents=========>' + e.toString());
      yield left(
          GeneralError('Error', 'Error happened, Please try again later'));
    }
  }

  @override
  Future<Either<GeneralError, EventModel>> getEvent(
      {String? eventId, required bool getUser}) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> doc = await FirebaseFirestore
          .instance
          .collection('Events')
          .doc(eventId!)
          .get();
      EventModel event = EventModel.fromMap(doc);
      if (getUser) {
        DocumentSnapshot<Map<String, dynamic>> userDoc = await FirebaseFirestore
            .instance
            .collection('Users')
            .doc(event.userId)
            .get();

        event.injectUser(UserModel.fromMap(userDoc));
      }
      return right(event);
    } catch (e) {
      return left(
          GeneralError('Error', 'Error happened, Please try again later'));
    }
  }

  @override
  Future<Either<GeneralError, bool>> submitReviewToEvent(
      {required ReviewModel reviewModel}) async {
    try {
      DocumentReference<Map<String, dynamic>> docRef =
          FirebaseFirestore.instance.collection('Reviews').doc();
      reviewModel.docId = docRef.id;
      await docRef.set(reviewModel.toMapForUpload());
      return right(true);
    } catch (e) {
      return left(
          GeneralError('Error', 'Error happened, Please try again later'));
    }
  }

  @override
  Future<Either<GeneralError, bool>> checkIsReviewPosted(
      {required String eventId, required String userId}) async {
    try {
      QuerySnapshot<Map<String, dynamic>> doc = await FirebaseFirestore.instance
          .collection('Reviews')
          .where('eventId', isEqualTo: eventId)
          .where('userId', isEqualTo: userId)
          .get();
      if (doc.docs.isEmpty) {
        return right(false);
      } else {
        return right(true);
      }
    } catch (e) {
      return right(true);
    }
  }

  @override
  Future<Either<GeneralError, List<ReviewModel>>> getUserReviews(
      {required String userId}) async {
    try {
      QuerySnapshot<Map<String, dynamic>> docs = await FirebaseFirestore
          .instance
          .collection('Reviews')
          .where('userId', isEqualTo: userId)
          .get();
      List<ReviewModel> reviews =
          docs.docs.map((e) => ReviewModel.fromMap(e)).toList();
      log(reviews.length.toString());
      return right(reviews);
    } catch (e) {
      return left(
          GeneralError('Error', 'Error happened, Please try again later'));
    }
  }

  @override
  Future<Either<GeneralError, bool>> makeRequest(
      {required RequestModel requestModel}) async {
    try {
      QuerySnapshot<Map<String, dynamic>> previousRequest =
          await FirebaseFirestore.instance
              .collection('Requests')
              .where('eventId', isEqualTo: requestModel.eventId)
              .where('userId', isEqualTo: requestModel.userId)
              .get();

      if (previousRequest.docs.isEmpty) {
        DocumentReference<Map<String, dynamic>> docRef =
            FirebaseFirestore.instance.collection('Requests').doc();
        requestModel.docId = docRef.id;
        await docRef.set(requestModel.toMapForUpload());
        return right(true);
      } else {
        return right(false);
      }
    } catch (e) {
      return left(
          GeneralError('Error', 'Error happened, Please try again later'));
    }
  }

  @override
  Future<Either<GeneralError, bool>> approveRequest(
      {required bool approve,
      required String requestId,
      required String eventId}) async {
    try {
      await FirebaseFirestore.instance
          .collection('Requests')
          .doc(requestId)
          .update({"isApproved": approve});
      return right(true);
    } catch (e) {
      return left(
          GeneralError('Error', 'Error happened, Please try again later'));
    }
  }

  @override
  Stream<Either<GeneralError, List<EventModel>>> getEventsRequestFromGM(
      {String? userId, required bool getUser}) async* {
    try {
      await for (QuerySnapshot<Map<String, dynamic>> eventsDocs
          in FirebaseFirestore.instance
              .collection('Events')
              .where('requestedTavern', isEqualTo: userId)
              .where('isApproved', isEqualTo: null)
              .snapshots()) {
        List<EventModel> events = [];
        for (QueryDocumentSnapshot<Map<String, dynamic>> eventDoc
            in eventsDocs.docs) {
          EventModel event = EventModel.fromMap(eventDoc);
          if (getUser) {
            DocumentSnapshot<Map<String, dynamic>> userDoc =
                await FirebaseFirestore.instance
                    .collection('Users')
                    .doc(event.userId)
                    .get();
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
      yield left(
          GeneralError('Error', 'Error happened, Please try again later'));
    }
  }

  @override
  Future<Either<GeneralError, bool>> updateEventRequest(
      {required bool approve, String? eventId}) async {
    try {
      await FirebaseFirestore.instance
          .collection('Events')
          .doc(eventId)
          .update({"isApproved": approve});
      return right(true);
    } catch (e) {
      return left(
          GeneralError('Error', 'Error happened, Please try again later'));
    }
  }

  @override
  Future<Either<GeneralError, bool>> addInEvent(
      {required String eventId, required String userId}) async {
    try {
      await FirebaseFirestore.instance
          .collection('Events')
          .doc(eventId)
          .update({
        "eventUsers": FieldValue.arrayUnion([userId]),
      });
      return right(true);
    } catch (e) {
      return left(
          GeneralError('Error', 'Error happened, Please try again later'));
    }
  }

  @override
  Stream<Either<GeneralError, List<EventModel>>> getCalenderData(
      {required String userId}) async* {
    try {
      await for (QuerySnapshot<Map<String, dynamic>> eventsDocs
          in FirebaseFirestore.instance
              .collection('Events')
              .where("eventUsers", arrayContains: userId)
              .snapshots()) {
        List<EventModel> events = [];
        for (QueryDocumentSnapshot<Map<String, dynamic>> eventDoc
            in eventsDocs.docs) {
          EventModel event = EventModel.fromMap(eventDoc);

          events.add(event);
        }

        yield Right(events);
      }
    } catch (e) {
      log('getEvents=========>' + e.toString());
      yield left(
          GeneralError('Error', 'Error happened, Please try again later'));
    }
  }
}
