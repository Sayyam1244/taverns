import 'package:taverns/domain/model/user_model.dart';

import 'tavern_profile_initial_params.dart';

class TavernProfileState {
  UserModel userModel;
  bool isloading;
  int reviewCount;
  int stars;
  TavernProfileState(
      {required this.userModel,
      required this.isloading,
      required this.reviewCount,
      required this.stars});

  factory TavernProfileState.initial(
          {required TavernProfileInitialParams initialParams}) =>
      TavernProfileState(
        userModel: UserModel(),
        isloading: true,
        reviewCount: 0,
        stars: 0,
      );

  TavernProfileState copyWith(
          {UserModel? userModel,
          bool? isloading,
          int? reviewCount,
          int? stars}) =>
      TavernProfileState(
          userModel: userModel ?? this.userModel,
          isloading: isloading ?? this.isloading,
          reviewCount: reviewCount ?? this.reviewCount,
          stars: stars ?? this.stars);
}
