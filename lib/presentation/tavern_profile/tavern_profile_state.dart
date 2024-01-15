import 'package:taverns/domain/model/user_model.dart';

import 'tavern_profile_initial_params.dart';

class TavernProfileState {
  UserModel userModel;
  bool isloading;
  TavernProfileState({required this.userModel, required this.isloading});

  factory TavernProfileState.initial({required TavernProfileInitialParams initialParams}) => TavernProfileState(
        userModel: UserModel(),
        isloading: true,
      );

  TavernProfileState copyWith({UserModel? userModel, bool? isloading}) => TavernProfileState(
        userModel: userModel ?? this.userModel,
        isloading: isloading ?? this.isloading,
      );
}
