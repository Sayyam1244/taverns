import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taverns/domain/model/user_model.dart';

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
  bool? isApproved;
  UserModel? user;
  String? requestedTavern;

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
    this.isApproved,
    this.requestedTavern,
    this.user,
  }) : super(
            docId: docId, createdDate: createdDate, modifiedDate: modifiedDate);

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
      'isApproved': isApproved,
      'requestedTavern': requestedTavern,
    };
  }

  factory EventModel.fromMap(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data()!;
    return EventModel(
        docId: data['docId'] ?? '',
        createdDate: data['creationDate']?.toDate(),
        modifiedDate: data['modifiedDate']?.toDate(),
        businessName: data['businessName'] ?? '',
        businessNumber: data['businessNumber'] ?? '',
        userId: data['userId'] ?? '',
        businessAddress: data['businessAddress'] ?? '',
        eventName: data['eventName'] ?? '',
        eventDatetime: data['eventDatetime']?.toDate(),
        eventType: data['eventType'] ?? '',
        gameType: data['gameType'] ?? '',
        gameSystem: data['gameSystem'] ?? '',
        isFree: data['isFree'] ?? false,
        gmsRequired: data['gmsRequired'] ?? 0,
        playerRequired: data['playerRequired'] ?? 0,
        tables: data['tables'] ?? 0,
        note: data['note'] ?? '',
        isApproved: data['isApproved'] ?? null,
        requestedTavern: data['requestedTavern'] ?? null);
  }
  injectUser(UserModel userModel) {
    user = userModel;
  }
}
