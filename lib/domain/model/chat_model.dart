import 'package:cloud_firestore/cloud_firestore.dart';
import 'common_model.dart';

class ChatModel extends CommonModel {
  final String? userId;
  final String? content;
  final String? TYPE;
  final String? sheetName;
  final int? level;
  final String? system;
  final String? category;
  final String? subCategory;

  ChatModel({
    this.userId,
    this.content,
    this.TYPE,
    this.sheetName,
    this.level,
    this.system,
    this.category,
    this.subCategory,
    String? docId,
    DateTime? createdDate,
    DateTime? modifiedDate,
  }) : super(
            docId: docId, createdDate: createdDate, modifiedDate: modifiedDate);

  Map<String, dynamic> toMapForUpload() {
    return {
      'userId': userId,
      'content': content,
      'TYPE': TYPE,
      'sheetName': sheetName,
      'level': level,
      'system': system,
      'category': category,
      'subCategory': subCategory,
      if (docId != null) 'docId': docId,
      'createdDate': FieldValue.serverTimestamp(),
      if (modifiedDate != null) 'modifiedDate': modifiedDate,
    };
  }

  factory ChatModel.fromMap(
      {required DocumentSnapshot<Map<String, dynamic>> snapshot}) {
    final data = snapshot.data()!;
    return ChatModel(
      userId: data['userId'],
      content: data['content'],
      TYPE: data['TYPE'],
      sheetName: data['sheetName'],
      level: data['level'],
      system: data['system'],
      category: data['category'],
      subCategory: data['subCategory'],
      docId: data['docId'],
      modifiedDate: data?['modifiedDate']?.toDate(),
      createdDate: data?['createdDate']?.toDate(),
    );
  }
}
