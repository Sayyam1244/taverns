import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taverns/domain/model/user_model.dart';
import 'package:taverns/domain/repository/auth_repository.dart';
import 'package:taverns/domain/repository/user_repository.dart';
import 'package:taverns/presentation/sign_up_select_role_screen/signup_select_role_navigator.dart';
import 'package:taverns/presentation/signup_completion/signup_completion_initial_params.dart';
import '../../core/utils/flushbar.dart';
import 'signup_select_role_initial_params.dart';
import 'signup_select_role_state.dart';

class SignupSelectRoleCubit extends Cubit<SignupSelectRoleState> {
  final SignupSelectRoleInitialParams initialParams;
  final SignupSelectRoleNavigator navigator;
  final UserRepository _user;
  final AuthRepository _auth;

  SignupSelectRoleCubit(
      this.initialParams, this.navigator, this._user, this._auth)
      : super(SignupSelectRoleState.initial(initialParams: initialParams));

  changeRole(int i) {
    emit(state.copyWith(selectedRoleIndex: i));
  }

  saveType(context) async {
    UserModel userModel = UserModel(
        accountType: state.userType[state.selectedRoleIndex],
        profileOnboardingCompleted: false);
    _user.createFirestoreUser(_auth.currentUser().uid, userModel).then((value) {
      return value.fold(
          (l) => FlushbarDialogue().showErrorFlushbar(
              context: context, title: l.title, body: l.message),
          (r) => navigator.openSignupCompletion(SignupCompletionInitialParams(
              type: state.userType[state.selectedRoleIndex])));
    });
  }
}
