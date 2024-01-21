import 'package:cloud_firestore/cloud_firestore.dart';
import 'common_model.dart';

class RequestModel extends CommonModel {
  String? userName;
  String? eventId;
  String? requestedFor;
  DateTime? requestedDate;
  bool? isApproved;
  DateTime? modifiedDate;

  RequestModel({
    String? docId,
    DateTime? createdDate,
    DateTime? modifiedDate,
    this.userName,
    this.eventId,
    this.requestedFor,
    this.requestedDate,
    this.isApproved,
  }) : super(docId: docId, createdDate: createdDate, modifiedDate: modifiedDate);

  Map<String, dynamic> toMapForUpload() {
    return {
      if (userName != null) 'userName': userName,
      if (eventId != null) 'eventId': eventId,
      if (requestedFor != null) 'requestedFor': requestedFor,
      'requestedDate': FieldValue.serverTimestamp(),
      if (isApproved != null) 'isApproved': isApproved,
      if (docId != null) 'docId': docId,
      if (createdDate != null) 'creationDate': createdDate,
      if (modifiedDate != null) 'modifiedDate': modifiedDate,
    };
  }

  factory RequestModel.fromMap(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();
    return RequestModel(
      docId: snapshot.id,
      createdDate: data?['createdDate']?.toDate(),
      modifiedDate: data?['modifiedDate']?.toDate(),
      userName: data?['userName'] ?? '',
      eventId: data?['eventId'] ?? '',
      requestedFor: data?['requestedFor'] ?? '',
      requestedDate: data?['requestedDate']?.toDate(),
      isApproved: data?['isApproved'] ?? false,
    );
  }
}
