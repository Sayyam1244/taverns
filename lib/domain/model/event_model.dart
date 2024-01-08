import 'package:cloud_firestore/cloud_firestore.dart';

import 'common_model.dart';

class EventModel extends CommonModel {
  String businessName;
  String businessNumber;
  String userId;
  String businessAddress;
  String eventName;
  DateTime eventDatetime;
  String eventType;
  String gameType;
  String gameSystem;
  bool isFree;
  int gmsRequired;
  int playerRequired;
  int tables;
  String note;

  EventModel({
    String? docId,
    DateTime? createdDate,
    DateTime? modifiedDate,
    required this.businessName,
    required this.businessNumber,
    required this.userId,
    required this.businessAddress,
    required this.eventName,
    required this.eventDatetime,
    required this.eventType,
    required this.gameType,
    required this.gameSystem,
    required this.isFree,
    required this.gmsRequired,
    required this.playerRequired,
    required this.tables,
    required this.note,
  }) : super(docId: docId, createdDate: createdDate, modifiedDate: modifiedDate);

  Map<String, dynamic> toMapForUpload() {
    return {
      if (docId != null) 'docId': docId,
      'creationDate': FieldValue.serverTimestamp(),
      if (modifiedDate != null) 'modifiedDate': modifiedDate,
      'businessName': businessName,
      'businessNumber': businessNumber,
      'userId': userId,
      'businessAddress': businessAddress,
      'eventName': eventName,
      'eventDatetime': eventDatetime.toUtc(),
      'eventType': eventType,
      'gameType': gameType,
      'gameSystem': gameSystem,
      'isFree': isFree,
      'gmsRequired': gmsRequired,
      'playerRequired': playerRequired,
      'tables': tables,
      'note': note,
    };
  }

  factory EventModel.fromMap(Map<String, dynamic> data, String documentId) {
    return EventModel(
      docId: documentId,
      createdDate: data['creationDate']?.toDate(),
      modifiedDate: data['modifiedDate']?.toDate(),
      businessName: data['businessName'] ?? '',
      businessNumber: data['businessNumber'] ?? '',
      userId: data['userId'] ?? '',
      businessAddress: data['businessAddress'] ?? '',
      eventName: data['eventName'] ?? '',
      eventDatetime: DateTime.parse(data['eventDatetime']),
      eventType: data['eventType'] ?? '',
      gameType: data['gameType'] ?? '',
      gameSystem: data['gameSystem'] ?? '',
      isFree: data['isFree'] ?? false,
      gmsRequired: data['gmsRequired'] ?? 0,
      playerRequired: data['playerRequired'] ?? 0,
      tables: data['tables'] ?? 0,
      note: data['note'] ?? '',
    );
  }
}
