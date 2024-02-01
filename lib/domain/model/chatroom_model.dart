import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taverns/domain/model/common_model.dart';

class ChatRoomModel {
  String? last;
  String? docId;
  List<String>? users;
  String? otherUsername;
  DateTime? lastModified;

  ChatRoomModel(
      {this.last,
      this.users,
      this.otherUsername,
      this.lastModified,
      this.docId});

  factory ChatRoomModel.fromMap(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data()!;

    return ChatRoomModel(
        docId: data?['docId'],
        lastModified: data?['lastModified']?.toDate(),
        users:
            (data?['users'] as List<dynamic>).map((e) => e.toString()).toList(),
        last: data?['last']);
  }
}
