import 'package:cloud_firestore/cloud_firestore.dart';

class CommonModel {
  String? docId;
  DateTime? createdDate;
  DateTime? modifiedDate;

  CommonModel({
    this.docId,
    this.createdDate,
    this.modifiedDate,
  });
}

class UserModel extends CommonModel {
  String? userName;
  String? email;
  bool? profileOnboardingCompleted;
  String? businessName;
  String? businessNumber;
  String? businessAddress;
  String? contactEmail;
  String? businessHours;
  String? accountType;
  String? lat;
  String? long;
  bool? likeReview;
  bool? eventsNearMe;
  bool? timeSlotsRequests;
  String? profilePicture;

UserModel({
  String? docId,
  DateTime? createdDate,
  DateTime? modifiedDate,
  required this.email,
  required this.profileOnboardingCompleted,
  required this.userName,
  required this.businessName,
  required this.businessNumber,
  required this.businessAddress,
  required this.contactEmail,
  required this.businessHours,
  required this.accountType,
  required this.lat,
  required this.long,
  required this.likeReview,
  required this.eventsNearMe,
  required this.timeSlotsRequests,
  required this.profilePicture,
}) : super(docId: docId, createdDate: createdDate, modifiedDate: modifiedDate);


  Map<String, dynamic> toMapForUpload() {
    return {
      'userName': userName,
      'email': email,
      'profileOnboardingCompleted': profileOnboardingCompleted,
      'docId': docId,
      'creationDate': createdDate,
      'modifiedDate': modifiedDate,
      'businessName': businessName,
      'businessNumber': businessNumber,
      'businessAddress': businessAddress,
      'contactEmail': contactEmail,
      'businessHours': businessHours,
      'accountType': accountType,
      'lat': lat,
      'long': long,
      'likeReview': likeReview,
      'eventsNearMe': eventsNearMe,
      'timeSlotsRequests': timeSlotsRequests,
      'profilePicture': profilePicture,
    };
  }

  factory UserModel.fromMap(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();
    return UserModel(
      docId: snapshot.id,
      createdDate: data?['createdDate']?.toDate(),
      modifiedDate: data?['modifiedDate']?.toDate(),
      email: data?['email'] ?? '',
      profileOnboardingCompleted: data?['profileOnboardingCompleted'] ?? false,
      userName: data?['userName'] ?? '',
      businessName: data?['businessName'] ?? '',
      businessNumber: data?['businessNumber'] ?? '',
      businessAddress: data?['businessAddress'] ?? '',
      contactEmail: data?['contactEmail'] ?? '',
      businessHours: data?['businessHours'] ?? '',
      accountType: data?['accountType'] ?? '',
      lat: data?['lat'] ?? '',
      long: data?['long'] ?? '',
      likeReview: data?['likeReview'] ?? false,
      eventsNearMe: data?['eventsNearMe'] ?? false,
      timeSlotsRequests: data?['timeSlotsRequests'] ?? false,
      profilePicture: data?['profilePicture'] ?? '',
    );
  }
}
