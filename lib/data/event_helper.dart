import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/src/either.dart';
import 'package:taverns/domain/model/event_model.dart';
import 'package:taverns/domain/model/general_model.dart';
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
}
