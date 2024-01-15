import 'package:cloud_firestore/cloud_firestore.dart';

import 'common_model.dart';

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
  String? marketPlaceLink;

  UserModel({
    String? docId,
    DateTime? createdDate,
    DateTime? modifiedDate,
    this.email,
    this.profileOnboardingCompleted,
    this.userName,
    this.businessName,
    this.businessNumber,
    this.businessAddress,
    this.contactEmail,
    this.businessHours,
    this.accountType,
    this.lat,
    this.long,
    this.likeReview,
    this.eventsNearMe,
    this.timeSlotsRequests,
    this.profilePicture,
    this.marketPlaceLink,
  }) : super(docId: docId, createdDate: createdDate, modifiedDate: modifiedDate);

  Map<String, dynamic> toMapForUpload() {
    return {
      if (userName != null) 'userName': userName,
      if (email != null) 'email': email,
      if (profileOnboardingCompleted != null) 'profileOnboardingCompleted': profileOnboardingCompleted,
      if (docId != null) 'docId': docId,
      if (createdDate != null) 'creationDate': createdDate,
      if (modifiedDate != null) 'modifiedDate': modifiedDate,
      if (businessName != null) 'businessName': businessName,
      if (businessNumber != null) 'businessNumber': businessNumber,
      if (businessAddress != null) 'businessAddress': businessAddress,
      if (contactEmail != null) 'contactEmail': contactEmail,
      if (businessHours != null) 'businessHours': businessHours,
      if (accountType != null) 'accountType': accountType,
      if (lat != null) 'lat': lat,
      if (long != null) 'long': long,
      if (likeReview != null) 'likeReview': likeReview,
      if (eventsNearMe != null) 'eventsNearMe': eventsNearMe,
      if (timeSlotsRequests != null) 'timeSlotsRequests': timeSlotsRequests,
      if (profilePicture != null) 'profilePicture': profilePicture,
      if (marketPlaceLink != null) 'marketPlaceLink': marketPlaceLink,
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
      marketPlaceLink: data?['marketPlaceLink'] ?? '',
    );
  }
}
