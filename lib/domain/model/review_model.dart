import 'package:cloud_firestore/cloud_firestore.dart';

import 'common_model.dart';

class ReviewModel extends CommonModel {
  String? userId;
  String? eventId;
  String? hostId;
  String? review;
  int? stars;
  String? name;

  ReviewModel({
    this.userId,
    this.eventId,
    this.hostId,
    this.review,
    this.stars,
    this.name,
    String? docId,
    DateTime? createdDate,
    DateTime? modifiedDate,
  }) : super(docId: docId, createdDate: createdDate, modifiedDate: modifiedDate);

  Map<String, dynamic> toMapForUpload() {
    return {
      if (userId != null) 'userId': userId,
      if (eventId != null) 'eventId': eventId,
      if (hostId != null) 'hostId': hostId,
      if (review != null) 'review': review,
      if (stars != null) 'stars': stars,
      if (docId != null) 'docId': docId,
      if (name != null) 'name': name,
      'createdDate': FieldValue.serverTimestamp(),
      if (modifiedDate != null) 'modifiedDate': modifiedDate,
    };
  }

  factory ReviewModel.fromMap(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();
    return ReviewModel(
      docId: snapshot.id,
      createdDate: data?['createdDate']?.toDate(),
      modifiedDate: data?['modifiedDate']?.toDate(),
      userId: data?['userId'] ?? '',
      eventId: data?['eventId'] ?? '',
      hostId: data?['hostId'] ?? '',
      review: data?['review'] ?? '',
      name: data?['name'] ?? '',
      stars: data?['stars'] ?? 0,
    );
  }
}
