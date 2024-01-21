import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taverns/domain/repository/user_repository.dart';
import 'package:taverns/presentation/edit_profile/edit_profile_initial_params.dart';
import 'package:taverns/presentation/tavern_profile/tavern_profile_navigator.dart';
import '../../core/utils/flushbar.dart';
import 'tavern_profile_initial_params.dart';
import 'tavern_profile_state.dart';

class TavernProfileCubit extends Cubit<TavernProfileState> {
  final TavernProfileInitialParams initialParams;
  final UserRepository _user;
  final TavernProfileNavigator navigator;
  TavernProfileCubit(this.initialParams, this._user, this.navigator) : super(TavernProfileState.initial(initialParams: initialParams));

  getTavernUserInfo(context) {
    _user.getUser(initialParams.docId).then((value) {
      return value.fold(
        (l) => FlushbarDialogue().showErrorFlushbar(context: context, title: l.title, body: l.message),
        (r) => emit(
          state.copyWith(isloading: false, userModel: r),
        ),
      );
    });
  }

  void navigateToEditProfileScreen() {
    navigator.openandRemoveProfile(EditProfileInitialParams(userModel: state.userModel));
  }
}
