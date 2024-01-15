import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taverns/domain/model/user_model.dart';
import 'package:taverns/domain/repository/user_repository.dart';
import 'package:taverns/presentation/edit_location_map/edit_location_on_map_initial_params.dart';
import 'package:taverns/presentation/edit_profile/edit_profile_navigator.dart';
import 'edit_profile_initial_params.dart';
import 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  final EditProfileInitialParams initialParams;
  final EditProfileNavigator navigator;
  final UserRepository _user;
  EditProfileCubit(this.initialParams, this.navigator, this._user) : super(EditProfileState.initial(initialParams: initialParams));

  void navigateToEditMapScreen(name, number, address, hours, marketPlace) {
    UserModel userModel = initialParams.userModel;
    userModel.businessName = name;
    userModel.businessNumber = number;
    userModel.businessAddress = address;
    userModel.businessHours = hours;
    userModel.marketPlaceLink = marketPlace;

    navigator.openEditLocationOnMap(EditLocationOnMapInitialParams(userModel));
  }
}
