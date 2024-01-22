import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taverns/domain/model/common_model.dart';

class NotificationModel extends CommonModel {
  String? notification;
  String? to;
  String? from;
  String? eventId;
  String? sender;
  NotificationModel({
    this.notification,
    this.to,
    this.from,
    this.eventId,
    this.sender,
    DateTime? createdDate,
    DateTime? modifiedDate,
    String? docId,
  }) : super(
          createdDate: createdDate,
          docId: docId,
          modifiedDate: modifiedDate,
        );

  toMapForUpload() {
    return {
      'notification': notification,
      'to': to,
      'from': from,
      'eventId': eventId,
      'sender': sender,
      if (docId != null) 'docId': docId,
      'createdDate': FieldValue.serverTimestamp(),
      if (modifiedDate != null) 'modifiedDate': modifiedDate,
    };
  }

  factory NotificationModel.fromMap(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();
    return NotificationModel(
      notification: data?['notification'],
      to: data?['to'],
      from: data?['from'],
      eventId: data?['eventId'],
      sender: data?['sender'],
      docId: data?['docId'] ?? '',
      createdDate: data?['createdDate']?.toDate(),
      modifiedDate: data?['modifiedDate']?.toDate(),
    );
  }
}
